package body SDL.TTF is
   
   procedure SDL_TTF_VERSION (X : access SDL_version) is
   begin
      X.major := SDL_TTF_MAJOR_VERSION;
      X.minor := SDL_TTF_MINOR_VERSION;
      X.patch := SDL_TTF_PATCHLEVEL;
   end SDL_TTF_VERSION;

end SDL.TTF;
