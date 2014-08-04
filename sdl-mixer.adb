package body SDL.Mixer is

   procedure SDL_MIXER_VERSION (X : access SDL_version) is
   begin
      X.major := SDL_MIXER_MAJOR_VERSION;
      X.minor := SDL_MIXER_MINOR_VERSION;
      X.patch := SDL_MIXER_PATCHLEVEL;
   end SDL_MIXER_VERSION;

   function Mix_LoadWAV (file : C.char_array) return access Mix_Chunk is
   begin
      return Mix_LoadWAV_RW (SDL_RWFromFile (file, C.To_C ("rb")), 1);
   end Mix_LoadWAV;

   function Mix_PlayChannel
     (channel : C.int;
      chunk   : access Mix_Chunk;
      loops   : C.int) return C.int
   is
   begin
      return Mix_PlayChannelTimed (channel, chunk, loops, -1);
   end Mix_PlayChannel;

   function Mix_FadeInChannel
     (channel : C.int;
      chunk   : access Mix_Chunk;
      loops   : C.int;
      ms      : C.int) return C.int
   is
   begin
      return Mix_FadeInChannelTimed (channel, chunk, loops, ms, -1);
   end Mix_FadeInChannel;

end SDL.Mixer;
