package body SDL.Image is
   
   procedure SDL_IMAGE_VERSION (X : access SDL_version) is
   begin
      X.major := SDL_IMAGE_MAJOR_VERSION;
      X.minor := SDL_IMAGE_MINOR_VERSION;
      X.patch := SDL_IMAGE_PATCHLEVEL;
   end SDL_IMAGE_VERSION;

end SDL.Image;
