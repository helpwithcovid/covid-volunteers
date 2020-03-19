# frozen_string_literal: true

module MetaTagHelper
  def title(content)
    content_for(:title) { content }
  end

  def share_img(content)
    content_for(:share_img) { content }
  end

  def share_url(content)
    content_for(:share_url) { content }
  end

  def share_desc(content)
    content_for(:share_desc) { content }
  end

  def share_title(content)
    content_for(:share_title) { content }
  end

  def share_twitter_card_type(content)
    content_for(:share_twitter_card_type) { content }
  end

  def dynamic_fav_ico(content)
    content_for(:dynamic_fav_ico) { content }
  end
end
