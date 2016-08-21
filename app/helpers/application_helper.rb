module ApplicationHelper

  # Retourner un titre basé sur la page.
  def titre
    base_titre = "Test automation sample app"
    if @titre.nil?
      base_titre
    else
      "#{base_titre} | #{@titre}"
    end
  end
  def logo
    image_tag("logo.png", :alt => "Ordina Belgium", :class => "round")
  end
end
