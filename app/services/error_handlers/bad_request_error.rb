module ErrorHandlers::BadRequestError
  def self.included(base)
    base.class_eval do
      rescue_from RailsParam::Param::InvalidParameterError, with: :bad_request_error
      rescue_from RuntimeError, with: :bad_request_error
      rescue_from Errno::ENOENT, with: :invalid_url
      rescue_from SocketError, with: :url_is_not_reachable

      def bad_request_error(exceptions)
        render json: { detail: exceptions.message }, status: 400
      end

      def invalid_url
        render json: { detail: I18n.t('errors.invalid_url') }, status: 400
      end

      def url_is_not_reachable
        render json: { detail: I18n.t('errors.wrong_url') }, status: 400
      end
    end
  end
end