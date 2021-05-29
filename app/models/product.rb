class Product < ApplicationRecord
  require "net/http"
  validates :name, presence: true, allow_blank: false
  validates :price, presence: true, allow_blank: false

  scope :active, -> { where(:active => true) }

  scope :viewed, -> { where("views > 0 ") }
  scope :active_viewed, -> { active.viewed }

  # scope :active_viewed, lambda { :conditions => ['views > ? AND active = ?', 1, true] }

  def update_view_and_save
    self.views = self.views + 1
    self.save
  end

  def mark_inactive
    self.active = false
  end

  def get_url_resp(key)
    begin
      uri_p = CURRENCY_CONVERTER_URL.gsub("%CURPATTERN%", key).gsub("%KEY%", CURRENCY_CONVERTER_API_KEY)
      uri = URI(uri_p)
      res = Net::HTTP.get_response(uri)
      if res.code == "200"
        val = JSON.parse(res.body)[key]
        return "#{(price.to_f * val).round(2)}"
      end
    rescue StandardError
      Rails.logger.fatal("[ERROR] Exception in Product.get_url_resp. Error in fetching response from #{uri_p}. Response code : #{res.code} ")
      return nil
    end
  end

  def convert_currency(price, source_cur, target_cur)
    return "#{price} #{source_cur}" if source_cur == target_cur
    return "#{get_url_resp("#{source_cur}_#{target_cur}")} #{target_cur}"
  end

  def as_json(options = {})
    json = super(options)
    converted_price = convert_currency(json["price"], DEFAULT_CURRENCY, options[:currency])
    json["price"] = converted_price #Modify price attribute to include currency
    json
  end
end
