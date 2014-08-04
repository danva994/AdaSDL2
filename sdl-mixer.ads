package SDL.Mixer is

   SDL_MIXER_MAJOR_VERSION : constant Uint8 := 2;
   SDL_MIXER_MINOR_VERSION : constant Uint8 := 0;
   SDL_MIXER_PATCHLEVEL    : constant Uint8 := 0;

   MIX_MAJOR_VERSION : constant Uint8 := SDL_MIXER_MAJOR_VERSION;
   MIX_MINOR_VERSION : constant Uint8 := SDL_MIXER_MINOR_VERSION;
   MIX_PATCHLEVEL    : constant Uint8 := SDL_MIXER_PATCHLEVEL;

   procedure SDL_MIXER_VERSION (X : access SDL_version);
   pragma Inline (SDL_MIXER_VERSION);

   procedure MIX_VERSION (X : access SDL_version) renames SDL_MIXER_VERSION;

   function Mix_Linked_Version return SDL_version;
   pragma Import (C, Mix_Linked_Version, "Mix_Linked_Version");

   subtype MIX_InitFlags is C.unsigned;
   MIX_INIT_FLAC       : constant MIX_InitFlags := 1;
   MIX_INIT_MOD        : constant MIX_InitFlags := 2;
   MIX_INIT_MODPLUG    : constant MIX_InitFlags := 4;
   MIX_INIT_MP3        : constant MIX_InitFlags := 8;
   MIX_INIT_OGG        : constant MIX_InitFlags := 16;
   MIX_INIT_FLUIDSYNTH : constant MIX_InitFlags := 32;

   function Mix_Init (flags : C.int) return C.int;
   pragma Import (C, Mix_Init, "Mix_Init");

   procedure Mix_Quit;
   pragma Import (C, Mix_Quit, "Mix_Quit");

   MIX_CHANNELS          : constant := 8;
   MIX_DEFAULT_FREQUENCY : constant := 22050;
   MIX_DEFAULT_CHANNELS  : constant := 2;
   MIX_MAX_VOLUME        : constant := 128;
   MIX_CHANNEL_POST      : constant := -2;
   -- MIX_DEFAULT_FORMAT : constant Uint16;

   MIX_EFFECTSMAXSPEED : aliased constant C.char_array :=
     C.To_C ("MIX_EFFECTSMAXSPEED");

   type Mix_Chunk is record
      allocated : aliased C.int;
      abuf      : access Uint8;
      alen      : aliased Uint32;
      volume    : aliased Uint8;
   end record;
   pragma Convention (C_Pass_By_Copy, Mix_Chunk);

   type Mix_Fading is (MIX_NO_FADING, MIX_FADING_OUT, MIX_FADING_IN);
   pragma Convention (C, Mix_Fading);

   type Mix_MusicType is
     (MUS_NONE,
      MUS_CMD,
      MUS_WAV,
      MUS_MOD,
      MUS_MID,
      MUS_OGG,
      MUS_MP3,
      MUS_MP3_MAD,
      MUS_FLAC,
      MUS_MODPLUG);
   pragma Convention (C, Mix_MusicType);

   subtype Mix_Music is System.Address;

   function Mix_OpenAudio
     (frequency : C.int;
      format    : Uint16;
      channels  : C.int;
      chunksize : C.int) return C.int;
   pragma Import (C, Mix_OpenAudio, "Mix_OpenAudio");

   function Mix_AllocateChannels (numchans : C.int) return C.int;
   pragma Import (C, Mix_AllocateChannels, "Mix_AllocateChannels");

   function Mix_QuerySpec
     (frequency : access C.int;
      format    : access Uint16;
      channels  : access C.int) return C.int;
   pragma Import (C, Mix_QuerySpec, "Mix_QuerySpec");

   function Mix_LoadWAV_RW
     (src     : access SDL_RWops;
      freesrc : C.int) return access Mix_Chunk;
   pragma Import (C, Mix_LoadWAV_RW, "Mix_LoadWAV_RW");

   function Mix_LoadWAV (file : C.char_array) return access Mix_Chunk;
   pragma Inline (Mix_LoadWAV);

   function Mix_LoadMUS (file : C.char_array) return access Mix_Music;
   pragma Import (C, Mix_LoadMUS, "Mix_LoadMUS");

   function Mix_LoadMUS_RW
     (src     : access SDL_RWops;
      freesrc : C.int) return access Mix_Music;
   pragma Import (C, Mix_LoadMUS_RW, "Mix_LoadMUS_RW");

   function Mix_LoadMUSType_RW
     (src     : access SDL_RWops;
      kind    : Mix_MusicType;
      freesrc : C.int) return access Mix_Music;
   pragma Import (C, Mix_LoadMUSType_RW, "Mix_LoadMUSType_RW");

   function Mix_QuickLoad_WAV (mem : access Uint8) return access Mix_Chunk;
   pragma Import (C, Mix_QuickLoad_WAV, "Mix_QuickLoad_WAV");

   function Mix_QuickLoad_RAW
     (mem : access Uint8;
      len : Uint32) return access Mix_Chunk;
   pragma Import (C, Mix_QuickLoad_RAW, "Mix_QuickLoad_RAW");

   procedure Mix_FreeChunk (chunk : access Mix_Chunk);
   pragma Import (C, Mix_FreeChunk, "Mix_FreeChunk");

   procedure Mix_FreeMusic (music : access Mix_Music);
   pragma Import (C, Mix_FreeMusic, "Mix_FreeMusic");

   function Mix_GetNumChunkDecoders return C.int;
   pragma Import (C, Mix_GetNumChunkDecoders, "Mix_GetNumChunkDecoders");

   function Mix_GetChunkDecoder (index : C.int) return C.Strings.chars_ptr;
   pragma Import (C, Mix_GetChunkDecoder, "Mix_GetChunkDecoder");

   function Mix_GetNumMusicDecoders return C.int;
   pragma Import (C, Mix_GetNumMusicDecoders, "Mix_GetNumMusicDecoders");

   function Mix_GetMusicDecoder (index : C.int) return C.Strings.chars_ptr;
   pragma Import (C, Mix_GetMusicDecoder, "Mix_GetMusicDecoder");

   function Mix_GetMusicType (music : access Mix_Music) return Mix_MusicType;
   pragma Import (C, Mix_GetMusicType, "Mix_GetMusicType");

   procedure Mix_SetPostMix
     (mix_func : access procedure
        (udata  : System.Address;
         stream : access Uint8;
         len    : C.int);
      arg : System.Address);
   pragma Import (C, Mix_SetPostMix, "Mix_SetPostMix");

   procedure Mix_HookMusic
     (mix_func : access procedure
        (udata  : System.Address;
         stream : access Uint8;
         len    : C.int);
      arg : System.Address);
   pragma Import (C, Mix_HookMusic, "Mix_HookMusic");

   procedure Mix_HookMusicFinished (music_finished : access procedure);
   pragma Import (C, Mix_HookMusicFinished, "Mix_HookMusicFinished");

   function Mix_GetMusicHookData return System.Address;
   pragma Import (C, Mix_GetMusicHookData, "Mix_GetMusicHookData");

   procedure Mix_ChannelFinished
     (channel_finished : access procedure (channel : C.int));
   pragma Import (C, Mix_ChannelFinished, "Mix_ChannelFinished");

   type Mix_EffectFunc_t is access procedure
     (chan   : C.int;
      stream : System.Address;
      len    : C.int;
      udata  : System.Address);
   pragma Convention (C, Mix_EffectFunc_t);

   type Mix_EffectDone_t is access procedure
     (chan  : C.int;
      udata : System.Address);
   pragma Convention (C, Mix_EffectDone_t);

   function Mix_RegisterEffect
     (chan : C.int;
      f    : Mix_EffectFunc_t;
      d    : Mix_EffectDone_t;
      arg  : System.Address) return C.int;
   pragma Import (C, Mix_RegisterEffect, "Mix_RegisterEffect");

   function Mix_UnregisterEffect
     (channel : C.int;
      f       : Mix_EffectFunc_t) return C.int;
   pragma Import (C, Mix_UnregisterEffect, "Mix_UnregisterEffect");

   function Mix_UnregisterAllEffects (channel : C.int) return C.int;
   pragma Import (C, Mix_UnregisterAllEffects, "Mix_UnregisterAllEffects");

   function Mix_SetPanning
     (channel : C.int;
      left    : Uint8;
      right   : Uint8) return C.int;
   pragma Import (C, Mix_SetPanning, "Mix_SetPanning");

   function Mix_SetPosition
     (channel  : C.int;
      angle    : Sint16;
      distance : Uint8) return C.int;
   pragma Import (C, Mix_SetPosition, "Mix_SetPosition");

   function Mix_SetDistance (channel : C.int; distance : Uint8) return C.int;
   pragma Import (C, Mix_SetDistance, "Mix_SetDistance");

   function Mix_SetReverseStereo (channel : C.int; flip : C.int) return C.int;
   pragma Import (C, Mix_SetReverseStereo, "Mix_SetReverseStereo");

   function Mix_ReserveChannels (num : C.int) return C.int;
   pragma Import (C, Mix_ReserveChannels, "Mix_ReserveChannels");

   function Mix_GroupChannel (which : C.int; tag : C.int) return C.int;
   pragma Import (C, Mix_GroupChannel, "Mix_GroupChannel");

   function Mix_GroupChannels
     (from : C.int;
      to   : C.int;
      tag  : C.int) return C.int;
   pragma Import (C, Mix_GroupChannels, "Mix_GroupChannels");

   function Mix_GroupAvailable (tag : C.int) return C.int;
   pragma Import (C, Mix_GroupAvailable, "Mix_GroupAvailable");

   function Mix_GroupCount (tag : C.int) return C.int;
   pragma Import (C, Mix_GroupCount, "Mix_GroupCount");

   function Mix_GroupOldest (tag : C.int) return C.int;
   pragma Import (C, Mix_GroupOldest, "Mix_GroupOldest");

   function Mix_GroupNewer (tag : C.int) return C.int;
   pragma Import (C, Mix_GroupNewer, "Mix_GroupNewer");

   function Mix_PlayChannelTimed
     (channel : C.int;
      chunk   : access Mix_Chunk;
      loops   : C.int;
      ticks   : C.int) return C.int;
   pragma Import (C, Mix_PlayChannelTimed, "Mix_PlayChannelTimed");

   function Mix_PlayChannel
     (channel : C.int;
      chunk   : access Mix_Chunk;
      loops   : C.int) return C.int;
   pragma Inline (Mix_PlayChannel);

   function Mix_PlayMusic
     (music : access Mix_Music;
      loops : C.int) return C.int;
   pragma Import (C, Mix_PlayMusic, "Mix_PlayMusic");

   function Mix_FadeInMusic
     (music : access Mix_Music;
      loops : C.int;
      ms    : C.int) return C.int;
   pragma Import (C, Mix_FadeInMusic, "Mix_FadeInMusic");

   function Mix_FadeInMusicPos
     (music    : access Mix_Music;
      loops    : C.int;
      ms       : C.int;
      position : C.double) return C.int;
   pragma Import (C, Mix_FadeInMusicPos, "Mix_FadeInMusicPos");

   function Mix_FadeInChannelTimed
     (channel : C.int;
      chunk   : access Mix_Chunk;
      loops   : C.int;
      ms      : C.int;
      ticks   : C.int) return C.int;
   pragma Import (C, Mix_FadeInChannelTimed, "Mix_FadeInChannelTimed");

   function Mix_FadeInChannel
     (channel : C.int;
      chunk   : access Mix_Chunk;
      loops   : C.int;
      ms      : C.int) return C.int;
   pragma Inline (Mix_FadeInChannel);

   function Mix_Volume (channel : C.int; volume : C.int) return C.int;
   pragma Import (C, Mix_Volume, "Mix_Volume");

   function Mix_VolumeChunk
     (chunk  : access Mix_Chunk;
      volume : C.int) return C.int;
   pragma Import (C, Mix_VolumeChunk, "Mix_VolumeChunk");

   function Mix_VolumeMusic (volume : C.int) return C.int;
   pragma Import (C, Mix_VolumeMusic, "Mix_VolumeMusic");

   function Mix_HaltChannel (channel : C.int) return C.int;
   pragma Import (C, Mix_HaltChannel, "Mix_HaltChannel");

   function Mix_HaltGroup (tag : C.int) return C.int;
   pragma Import (C, Mix_HaltGroup, "Mix_HaltGroup");

   function Mix_HaltMusic return C.int;
   pragma Import (C, Mix_HaltMusic, "Mix_HaltMusic");

   function Mix_ExpireChannel (channel : C.int; ticks : C.int) return C.int;
   pragma Import (C, Mix_ExpireChannel, "Mix_ExpireChannel");

   function Mix_FadeOutChannel (which : C.int; ms : C.int) return C.int;
   pragma Import (C, Mix_FadeOutChannel, "Mix_FadeOutChannel");

   function Mix_FadeOutGroup (tag : C.int; ms : C.int) return C.int;
   pragma Import (C, Mix_FadeOutGroup, "Mix_FadeOutGroup");

   function Mix_FadeOutMusic (ms : C.int) return C.int;
   pragma Import (C, Mix_FadeOutMusic, "Mix_FadeOutMusic");

   function Mix_FadingMusic return Mix_Fading;
   pragma Import (C, Mix_FadingMusic, "Mix_FadingMusic");

   function Mix_FadingChannel (which : C.int) return Mix_Fading;
   pragma Import (C, Mix_FadingChannel, "Mix_FadingChannel");

   procedure Mix_Pause (channel : C.int);
   pragma Import (C, Mix_Pause, "Mix_Pause");

   procedure Mix_Resume (channel : C.int);
   pragma Import (C, Mix_Resume, "Mix_Resume");

   function Mix_Paused (channel : C.int) return C.int;
   pragma Import (C, Mix_Paused, "Mix_Paused");

   procedure Mix_PauseMusic;
   pragma Import (C, Mix_PauseMusic, "Mix_PauseMusic");

   procedure Mix_ResumeMusic;
   pragma Import (C, Mix_ResumeMusic, "Mix_ResumeMusic");

   procedure Mix_RewindMusic;
   pragma Import (C, Mix_RewindMusic, "Mix_RewindMusic");

   function Mix_PausedMusic return C.int;
   pragma Import (C, Mix_PausedMusic, "Mix_PausedMusic");

   function Mix_SetMusicPosition (position : C.double) return C.int;
   pragma Import (C, Mix_SetMusicPosition, "Mix_SetMusicPosition");

   function Mix_Playing (channel : C.int) return C.int;
   pragma Import (C, Mix_Playing, "Mix_Playing");

   function Mix_PlayingMusic return C.int;
   pragma Import (C, Mix_PlayingMusic, "Mix_PlayingMusic");

   function Mix_SetMusicCMD (command : C.char_array) return C.int;
   pragma Import (C, Mix_SetMusicCMD, "Mix_SetMusicCMD");

   function Mix_SetSynchroValue (value : C.int) return C.int;
   pragma Import (C, Mix_SetSynchroValue, "Mix_SetSynchroValue");

   function Mix_GetSynchroValue return C.int;
   pragma Import (C, Mix_GetSynchroValue, "Mix_GetSynchroValue");

   function Mix_SetSoundFonts (paths : C.char_array) return C.int;
   pragma Import (C, Mix_SetSoundFonts, "Mix_SetSoundFonts");

   function Mix_GetSoundFonts return C.Strings.chars_ptr;
   pragma Import (C, Mix_GetSoundFonts, "Mix_GetSoundFonts");

   function Mix_EachSoundFont
     (func : access function
        (arg1 : Interfaces.C.char_array;
         arg2 : System.Address) return C.int;
      data : System.Address) return C.int;
   pragma Import (C, Mix_EachSoundFont, "Mix_EachSoundFont");

   function Mix_GetChunk (channel : C.int) return access Mix_Chunk;
   pragma Import (C, Mix_GetChunk, "Mix_GetChunk");

   procedure Mix_CloseAudio;
   pragma Import (C, Mix_CloseAudio, "Mix_CloseAudio");

   procedure Mix_SetError (text : C.char_array) renames SDL_SetError;
   function Mix_GetError return C.Strings.chars_ptr renames SDL_GetError;

end SDL.Mixer;
