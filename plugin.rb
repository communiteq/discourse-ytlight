#!/bin/env ruby
# encoding: utf-8
# name: lightweight YouTube oneboxer
# version: 0.1
# authors: cfstras


register_javascript <<JS
$(document).on('click', '.ytlight', function() {
    // Create an iFrame with autoplay set to true
    var iframe = $('<iframe class="ytlight" src="//www.youtube.com/embed/'+ this.id
        + '?autoplay=1&autohide=1&border=0&wmode=opaque&enablejsapi=1&start=' +
        $(this).data("time")+ '" />');

    // Replace the YouTube thumbnail with YouTube HTML5 Player
    $(this).empty().append(iframe);
});
JS

register_css <<CSS

.ytlight {
  width: 690px;
  height: 387px;
}

iframe.ytlight {
  border: none;
}

div.ytlight {
  margin-top: 1em;
  margin-bottom: 1em;
  background-color: #000;
  position: relative;
  overflow: hidden;
}

.ytlight_thumb,.ytlight_circle {
  cursor: hand;
  cursor: pointer;
}

.ytlight_thumb {
  /* center&cutoff */
  width: 100%;
  height: auto;
  position: absolute;
  top: -9999px;
  bottom: -9999px;
  left: -9999px;
  right: -9999px;
  margin: auto;
}

.ytlight_circle{
  opacity: .8;
  height: 77px;
  left: 50%;
  margin-left: -38px;
  margin-top: -38px;
  position: absolute;
  top: 50%;
  width: 77px;
  background: url("data:image/png;base64,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") no-repeat;
}
CSS

# Without this, all the Onebox stuff isn't loaded,
# so methods like `matches_regexp` do not work.
# It's weird. I know.
Onebox = Onebox
class Onebox::Engine::YTLightOnebox
  include Onebox::Engine

  def self.priority
    0
  end

  ## https://www.youtube.com/watch?v=Z0UISCEe52Y
  ## http://youtu.be/afyK1HSFfgw

  REGEX = /^https?:\/\/(?:www\.)?(?:youtube\.com\/(?:watch\?(?:feature=[^&]*&)?v=|embed)|youtu\.be\/)([a-zA-Z0-9_\-]{11})(?:[#&\?]t=(([0-9]+[smh]?)+))?$/

  matches_regexp REGEX

  def id
    @url.match(REGEX)[1]
  end

  def time
    # youtube embed api does not seem to like this new url format
    time = @url.match(REGEX)[2]
    if !time.nil? and !time.empty?
      parts = time.match(/(?:([0-9]+)h)?(?:([0-9]+)m)?(?:([0-9]+)s)?/)
        .to_a.map {|a| a.to_i}
      hrs  = parts[1]
      mins = parts[2]
      secs = parts[3]
      hrs*3600 + mins*60 + secs
    else
      0
    end
  end

  def url
    "//www.youtube.com/watch?v=#{id}"
  end

  def to_html
    <<HTML
<div class="ytlight" id="#{id}" data-time="#{time}">
  <img src="//i.ytimg.com/vi/#{id}/hqdefault.jpg" class="ytlight_thumb">
  <div class="ytlight_circle" />
</div>
HTML
  end
end

