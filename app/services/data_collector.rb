class DataCollector
  attr_accessor :doc
  
  def initialize(doc)
    @doc = doc
  end

  def process
    render_json
  end

  private

  def render_json
    {
      title: get_title,
      purchase_price: get_purchase_price,
      living_space: get_living_space,
      number_of_rooms: get_number_of_rooms,
      zip_code: get_zip_code,
      city: get_city,
      street: get_street,
      house_number: get_house_number,
      documents: get_documents,
      images: get_images
    }
  end
  
  def get_title
    doc.search('h1')&.first&.content
  end

  def get_purchase_price
    doc.search('.hardfacts .hardfact strong').children[0].content&.gsub('.', '').to_i
  end

  def get_living_space
    doc.search('.hardfacts .hardfact')[1].children[0].content.gsub(',', '.').to_f
  end

  def get_number_of_rooms
    doc.search('.hardfact.rooms')&.first&.content.to_i
  end

  def get_zip_code
    location&.split()&.first
  end

  def get_city
    location&.split()&.second&.gsub(',', '')
  end

  def get_street
    street = location&.scan(/.* (.+) Str.*/)&.flatten&.first
    street.present? ? "#{street} Str." : ""
  end

  def get_house_number
    location&.scan(/.*Str. (\d+)/)&.flatten&.first
  end

  def get_documents
    documents = []

    doc.search('a.icon-pdf').each do |doc| 
      next unless is_valid_url?(doc['href'])
      documents << doc['href']
    end

    documents.uniq
  end

  def get_images
    images_data = JSON.parse(
      doc.search('script').children[8].content.match( /{.+}/ )[0]
    )

    images_data["imageData"].map do |image|
      {
        title: image['srcImageStage'],
        url: image['caption']
      } 
    end
  end

  def location
    doc.search('.location')&.first&.content
  end

  def is_valid_url?(url)
    url =~ URI::regexp(%w(http https))
  end
  
end