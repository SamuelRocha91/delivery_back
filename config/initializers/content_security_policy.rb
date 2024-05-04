Rails.application.config.content_security_policy do |policy|
  policy.default_src :self
  policy.font_src    :self, :data
  policy.img_src     :self, :data
  policy.object_src  :none
  policy.script_src  :self
  policy.style_src   :self

  # Especifique URIs para `connect-src` se você estiver fazendo chamadas de API
  policy.connect_src :self, 'http://localhost:3000'

  # Especifique URIs para `frame-src` se você estiver usando iframes
  policy.frame_src :self, 'http://localhost:3000'

  # Você pode ajustar mais diretivas conforme necessário
end