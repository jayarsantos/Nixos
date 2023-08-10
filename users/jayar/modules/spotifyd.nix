{
  ...
}:
 {
  services.spotifyd = {
    settings.global = {
      username = "22xgzzxdkzg7phrp3elveoviy";
      password_cmd = "pass spotify/spotifyd";
      backend = "pulseaudio";
      device_name = "spotifyd";
      bitrate = 320;
      cache_path = "$HOME/.cache/spotifyd";
      device_type = "computer";
      initial_volume = "60";
      zeroconf_port = 4444;
      volume_controller = "softvol";
      volume_normalisation = false;
      no_audio_cache = false;
    };
  };
}
