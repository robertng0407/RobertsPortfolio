module ApplicationHelper
  def login_helper style = ''
    if current_user.is_a?(GuestUser)
      (link_to 'Register', new_user_registration_path, class: style) +
      " ".html_safe +
      (link_to 'Login', new_user_session_path, class: style)
    else
      link_to 'Logout', destroy_user_session_path, method: :delete, class: style
    end
  end

  def source_helper(layout_name)
    if session[:source]
      greeting = "Thanks for visiting me from #{session[:source]} and you are on they #{layout_name} layout"
      content_tag(:p, greeting, class: "source-greeting")
    end
  end

  def copyright_generator
    RobertViewTool::Renderer.copyright 'Robert Nguyen', 'All rights reserved'
  end

  def nav_items
    [
      {
        url: root_path,
        title: 'Home'
      },
      {
        url: about_me_path,
        title: 'About'
      },
      {
        url: contact_path,
        title: 'Contact'
      },
      {
        url: blogs_path,
        title: 'Travel_blog'
      },
      {
        url: portfolios_path,
        title: 'Portfolio'
      },
    ]
  end

  def nav_helper(style, tag_type)
# nav_links = <<NAV
# <#{tag_type}><a href="#{root_path}" class="#{style} #{active? root_path}">Home</a></#{tag_type}>
# <#{tag_type}><a href="#{about_me_path}" class="#{style} #{active? about_me_path}">About</a></#{tag_type}>
# <#{tag_type}><a href="#{contact_path}" class="#{style} #{active? contact_path}">Contact</a></#{tag_type}>
# <#{tag_type}><a href="#{blogs_path}" class="#{style} #{active? blogs_path}">Blog</a></#{tag_type}>
# <#{tag_type}><a href="#{portfolios_path}" class="#{style} #{active? portfolios_path}">Portfolio</a></#{tag_type}>
# NAV

    nav_links = ''

    nav_items.each do |item|
      nav_links << "<#{tag_type}><a href='#{item[:url]}' class='#{style} #{active? item[:url]}'>#{item[:title]}</a></#{tag_type}>"
    end

    nav_links.html_safe
  end

  def active? path
    "active" if current_page? path
  end

  def alerts
    alert = (flash[:alert] || flash[:error] || flash[:notice])

    if alert
      alert_generator alert
    end
  end

  def alert_generator msg
    js add_gritter(msg, title: "Robert Nguyen's Portfolio", sticky: false)
  end
end
