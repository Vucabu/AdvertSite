module UsersHelper
  def gravatar_for(user, options = { size: 50 })
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    size = options[:size]
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
    image_tag(gravatar_url, alt: user.name, class: "gravatar")
  end

  def admin?
    if signed_in? && !current_user.role_id.blank?
      current_user.role.id == Role.where(:name => "Admin").first.id
    else
      false
    end
  end
end
