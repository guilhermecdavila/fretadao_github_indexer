class WebscrapperService
  def initialize(github_url:)
    @github_url = github_url
    @attributes = {}
  end

  def scam
    @page = Watir::Browser.new(:firefox, headless: true)
    @page.window.maximize
    @page.goto(github_url)
    sleep(1)
    extract(@page)
    @page.close
    attributes
  end

  def extract(page)
    attributes[:image_url] = image_url
    attributes[:contribution] = contribution
    attributes[:nickname] = nickname
    attributes[:followers] = followers
    attributes[:following] = following
    attributes[:stars] = stars
    attributes[:organization] = organization
    attributes[:location] = location

    attributes
  end

  private

  attr_accessor :github_url, :attributes, :page

  def image_url
    return nil unless page.a(itemprop: 'image').exists?
    page.a(itemprop: 'image').href
  end

  def contribution
    return nil unless page.element(css: "#js-contribution-activity-description").exists?
    page
      .element(css: "#js-contribution-activity-description")
      .wait_until(&:present?)
      .text.scan(/\d/).join('')
  end

  def nickname
    return nil unless page.span(itemprop: 'additionalName').exists?
    page.span(itemprop: 'additionalName').text
  end

  def followers
    return nil unless page.element(css: ".js-profile-editable-area").exists?
    profile = page.element(css: ".js-profile-editable-area")
    return nil if profile.elements(css: '.color-fg-default').empty?
    profile.elements(css: '.color-fg-default').first.text
  end

  def following
    return nil unless page.element(css: ".js-profile-editable-area").exists?
    profile = page.element(css: ".js-profile-editable-area")
    return nil if profile.elements(css: '.color-fg-default').empty?
    profile.elements(css: '.color-fg-default').last.text
  end

  def stars
    return nil unless page.element("data-tab-item" => 'stars').exists?
    stars = page.element("data-tab-item" => 'stars')
    return nil if stars.element(class: "Counter").text.blank?
    stars.element(class: "Counter").text.scan(/\d/).join('')
  end

  def organization
    return nil unless page.element(itemprop: 'worksFor').exists? 
    page.element(itemprop: 'worksFor').text
  end

  def location
    return nil unless page.element(itemprop: 'homeLocation').exists? 
    page.element(itemprop: 'homeLocation').text
  end
end
