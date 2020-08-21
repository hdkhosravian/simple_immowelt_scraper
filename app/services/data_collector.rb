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
    doc.search('app-price')&.first&.content&.gsub('.', '').to_i
  end

  def get_living_space
    doc.search('app-hardfacts/div[1]/span')&.first&.content&.gsub(',', '.').to_f
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

    doc.search('app-documents').children.each do |child| 
      child.search('a').each do |document|
        documents << document['href']
      end
    end

    documents.uniq
  end

  def get_images
    images = []

    doc.search('app-images').children.each do |child| 
      child.search('img').each do |image|
        next unless image['src'].include? '/0x480'

        images << {
          title: image['alt'],
          url: image['src']
        } 
      end
    end

    images.uniq {|i| i[:url] }
  end

  def location
    doc.search('.location')&.first&.content
  end
end