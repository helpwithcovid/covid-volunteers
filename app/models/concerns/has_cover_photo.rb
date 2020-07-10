
module HasCoverPhoto
  extend ActiveSupport::Concern
  included do
    has_one_attached :image

      after_save do
        Rails.cache.delete cdn_image_cache_key
      end
  end

  # Because Active Storage doesn't support serving files through cloudfront (or any other way)
  # we need to manually strip the S3 path and prepend it with the CDN url
  def cdn_url(url)
    regex = /.*amazonaws\.com(\/.*)/
    url = url.split('?').first
    path = regex.match(url).captures

    return url if path.nil?

    "#{ENV['CDN_URL']}#{path.first}"
  end

  def cdn_image_cache_key
    "#{self.class.to_s.downcase}_cdn_cover_photo_#{id}"
  end

  def cdn_variant(resize_to_limit: nil)
    # Set the default
    image = self.image

    begin
      # Try and fetch the resized variant
      image = self.image.variant(resize_to_limit: resize_to_limit).processed
    rescue; end

    begin
      # Making sure the variant is processed before serving
      cdn_url(image.service_url)
    rescue
      image.service_url
    end
  end
end
