with Interfaces;

package body SDL is

   ----------------------------------------------------------------------------
   -- SDL_version.h
   ----------------------------------------------------------------------------

   procedure SDL_SOURCEVERSION (x : access SDL_version) is
   begin
      x.major := SDL_MAJOR_VERSION;
      x.minor := SDL_MINOR_VERSION;
      x.patch := SDL_PATCHLEVEL;
   end SDL_SOURCEVERSION;

   function SDL_VERSIONNUM (X, Y, Z : Uint8) return C.int is
   begin
      return C.int (X) * 1000 + C.int (Y) * 100 + C.int (Z);
   end SDL_VERSIONNUM;

   function SDL_COMPILEDVERSION return C.int is
   begin
      return SDL_VERSIONNUM
          (SDL_MAJOR_VERSION,
           SDL_MINOR_VERSION,
           SDL_PATCHLEVEL);
   end SDL_COMPILEDVERSION;

   function SDL_VERSION_ATLEAST (X, Y, Z : Uint8) return SDL_bool is
   begin
      if SDL_COMPILEDVERSION >= SDL_VERSIONNUM (X, Y, Z) then
         return SDL_TRUE;
      else
         return SDL_FALSE;
      end if;
   end SDL_VERSION_ATLEAST;

   ----------------------------------------------------------------------------
   -- SDL_timer.h
   ----------------------------------------------------------------------------

   function SDL_TICKS_PASSED (A, B : Uint32) return SDL_bool is
   begin
      if (Sint32 (B) - Sint32 (A)) <= 0 then
         return SDL_TRUE;
      else
         return SDL_FALSE;
      end if;
   end SDL_TICKS_PASSED;

   ----------------------------------------------------------------------------
   -- SDL_rwops.h
   ----------------------------------------------------------------------------

   function SDL_RWsize (ctx : access SDL_RWops) return Sint64 is
   begin
      return ctx.size (ctx);
   end SDL_RWsize;

   function SDL_RWseek
     (ctx    : access SDL_RWops;
      offset : Sint64;
      whence : C.int) return Sint64
   is
   begin
      return ctx.seek (ctx, offset, whence);
   end SDL_RWseek;

   function SDL_RWtell (ctx : access SDL_RWops) return Sint64 is
   begin
      return ctx.seek (ctx, 0, RW_SEEK_CUR);
   end SDL_RWtell;

   function SDL_RWread
     (ctx  : access SDL_RWops;
      ptr  : System.Address;
      size : C.size_t;
      n    : C.size_t) return C.size_t
   is
   begin
      return ctx.read (ctx, ptr, size, n);
   end SDL_RWread;

   function SDL_RWwrite
     (ctx  : access SDL_RWops;
      ptr  : System.Address;
      size : C.size_t;
      n    : C.size_t) return C.size_t
   is
   begin
      return ctx.write (ctx, ptr, size, n);
   end SDL_RWwrite;

   function SDL_RWclose (ctx : access SDL_RWops) return C.int is
   begin
      return ctx.close (ctx);
   end SDL_RWclose;

   ----------------------------------------------------------------------------
   -- SDL_pixels.h
   ----------------------------------------------------------------------------

   function ShiftRight (Value : Uint32; Amount : Natural) return Uint32 is
   begin
      return Uint32
          (Interfaces.Shift_Right (Interfaces.Unsigned_32 (Value), Amount));
   end ShiftRight;

   function ShiftLeft (Value : Uint32; Amount : Natural) return Uint32 is
   begin
      return Uint32
          (Interfaces.Shift_Left (Interfaces.Unsigned_32 (Value), Amount));
   end ShiftLeft;

   function SDL_DEFINE_PIXELFORMAT
     (typ    : C.int;
      order  : C.int;
      layout : C.int;
      bits   : C.int;
      bytes  : C.int) return Uint32
   is
   begin
      return
        ((ShiftLeft (1, 28)) or
         (ShiftLeft (Uint32 (typ), 24)) or
         (ShiftLeft (Uint32 (order), 20)) or
         (ShiftLeft (Uint32 (layout), 16)) or
         (ShiftLeft (Uint32 (bits), 8)) or
         (ShiftLeft (Uint32 (bytes), 0)));
   end SDL_DEFINE_PIXELFORMAT;

   function SDL_PIXELFLAG (X : Uint32) return C.int is
   begin
      return C.int (ShiftRight (X, 28) and 16#0F#);
   end SDL_PIXELFLAG;

   function SDL_PIXELTYPE (X : Uint32) return C.int is
   begin
      return C.int (ShiftRight (X, 24) and 16#0F#);
   end SDL_PIXELTYPE;

   function SDL_PIXELORDER (X : Uint32) return C.int is
   begin
      return C.int (ShiftRight (X, 20) and 16#0F#);
   end SDL_PIXELORDER;

   function SDL_PIXELLAYOUT (X : Uint32) return C.int is
   begin
      return C.int (ShiftRight (X, 16) and 16#0F#);
   end SDL_PIXELLAYOUT;

   function SDL_BITSPERPIXEL (X : Uint32) return C.int is
   begin
      return C.int (ShiftRight (X, 8) and 16#FF#);
   end SDL_BITSPERPIXEL;

   function SDL_BYTESPERPIXEL (X : Uint32) return C.int is
   begin
      if (SDL_ISPIXELFORMAT_FOURCC (X) = SDL_TRUE) then
         if
           ((X = SDL_PIXELFORMAT_YUY2)
            or else (X = SDL_PIXELFORMAT_UYVY)
            or else (X = SDL_PIXELFORMAT_YVYU))
         then
            return 2;
         else
            return 1;
         end if;
      else
         return C.int (ShiftRight (X, 0) and 16#FF#);
      end if;
   end SDL_BYTESPERPIXEL;

   function SDL_ISPIXELFORMAT_FOURCC (format : Uint32) return SDL_bool is
   begin
      if (format /= 0) and then (SDL_PIXELFLAG (format) /= 1) then
         return SDL_TRUE;
      else
         return SDL_FALSE;
      end if;
   end SDL_ISPIXELFORMAT_FOURCC;

   function SDL_ISPIXELFORMAT_INDEXED (format : Uint32) return SDL_bool is
   begin
      if
        ((SDL_ISPIXELFORMAT_FOURCC (format) = SDL_FALSE)
         and then
         ((SDL_PIXELTYPE (format) = SDL_PIXELTYPE_INDEX1)
          or else (SDL_PIXELTYPE (format) = SDL_PIXELTYPE_INDEX4)
          or else (SDL_PIXELTYPE (format) = SDL_PIXELTYPE_INDEX8)))
      then
         return SDL_TRUE;
      else
         return SDL_FALSE;
      end if;
   end SDL_ISPIXELFORMAT_INDEXED;

   function SDL_ISPIXELFORMAT_ALPHA (format : Uint32) return SDL_bool is
   begin
      if
        ((SDL_ISPIXELFORMAT_FOURCC (format) = SDL_FALSE)
         and then
         ((SDL_PIXELORDER (format) = SDL_PACKEDORDER_ARGB)
          or else (SDL_PIXELORDER (format) = SDL_PACKEDORDER_RGBA)
          or else (SDL_PIXELORDER (format) = SDL_PACKEDORDER_ABGR)
          or else (SDL_PIXELORDER (format) = SDL_PACKEDORDER_BGRA)))
      then
         return SDL_TRUE;
      else
         return SDL_FALSE;
      end if;
   end SDL_ISPIXELFORMAT_ALPHA;

   ----------------------------------------------------------------------------
   -- SDL_surface.h
   ----------------------------------------------------------------------------

   function SDL_MUSTLOCK (S : access SDL_Surface) return SDL_bool is
   begin
      if ((S.flags and SDL_RLEACCEL) /= 0) then
         return SDL_TRUE;
      else
         return SDL_FALSE;
      end if;
   end SDL_MUSTLOCK;

   function SDL_LoadBMP (file : C.char_array) return access SDL_Surface is
   begin
      return SDL_LoadBMP_RW (SDL_RWFromFile (file, C.To_C ("rb")), 1);
   end SDL_LoadBMP;

   function SDL_SaveBMP
     (surface : access SDL_Surface;
      file    : C.char_array) return C.int
   is
   begin
      return SDL_SaveBMP_RW (surface, SDL_RWFromFile (file, C.To_C ("wb")), 1);
   end SDL_SaveBMP;

   ----------------------------------------------------------------------------
   -- SDL_video.h
   ----------------------------------------------------------------------------

   function SDL_WINDOWPOS_UNDEFINED_DISPLAY (X : C.int) return C.int is
   begin
      return C.int (Uint32 (SDL_WINDOWPOS_UNDEFINED_MASK) or Uint32 (X));
   end SDL_WINDOWPOS_UNDEFINED_DISPLAY;

   function SDL_WINDOWPOS_UNDEFINED return C.int is
   begin
      return SDL_WINDOWPOS_UNDEFINED_DISPLAY (0);
   end SDL_WINDOWPOS_UNDEFINED;

   function SDL_WINDOWPOS_ISUNDEFINED (X : C.int) return SDL_bool is
   begin
      if ((Uint32 (X) and 16#FFFF0000#) = SDL_WINDOWPOS_UNDEFINED_MASK) then
         return SDL_TRUE;
      else
         return SDL_FALSE;
      end if;
   end SDL_WINDOWPOS_ISUNDEFINED;

   function SDL_WINDOWPOS_CENTERED_DISPLAY (X : C.int) return C.int is
   begin
      return C.int (Uint32 (SDL_WINDOWPOS_CENTERED_MASK) or Uint32 (X));
   end SDL_WINDOWPOS_CENTERED_DISPLAY;

   function SDL_WINDOWPOS_CENTERED return C.int is
   begin
      return SDL_WINDOWPOS_CENTERED_DISPLAY (0);
   end SDL_WINDOWPOS_CENTERED;

   function SDL_WINDOWPOS_ISCENTERED (X : C.int) return SDL_bool is
   begin
      if ((Uint32 (X) and 16#FFFF0000#) = SDL_WINDOWPOS_CENTERED_MASK) then
         return SDL_TRUE;
      else
         return SDL_FALSE;
      end if;
   end SDL_WINDOWPOS_ISCENTERED;

   ----------------------------------------------------------------------------
   -- SDL_shape.h
   ----------------------------------------------------------------------------

   function SDL_SHAPEMODEALPHA (mode : WindowShapeMode) return SDL_bool is
   begin
      if
        ((mode = ShapeModeDefault)
         or else (mode = ShapeModeBinarizeAlpha)
         or else (mode = ShapeModeReverseBinarizeAlpha))
      then
         return SDL_TRUE;
      else
         return SDL_FALSE;
      end if;
   end SDL_SHAPEMODEALPHA;

   ----------------------------------------------------------------------------
   -- SDL_keycode.h
   ----------------------------------------------------------------------------

   function SDL_SCANCODE_TO_KEYCODE (X : SDL_Scancode) return SDL_Keycode is
   begin
      return SDL_Keycode (Uint32 (X) or SDLK_SCANCODE_MASK);
   end SDL_SCANCODE_TO_KEYCODE;

   ----------------------------------------------------------------------------
   -- SDL_mouse.h
   ----------------------------------------------------------------------------

   function SDL_BUTTON (X : C.int) return C.int is
   begin
      return C.int (ShiftLeft (1, Natural ((X - 1))));
   end SDL_BUTTON;

   ----------------------------------------------------------------------------
   -- SDL_events.h
   ----------------------------------------------------------------------------

   function SDL_GetEventState (typ : Uint32) return Uint8 is
   begin
      return SDL_EventState (typ, SDL_QUERY);
   end SDL_GetEventState;

   ----------------------------------------------------------------------------
   -- SDL_audio.h
   ----------------------------------------------------------------------------

   function SDL_AUDIO_BITSIZE (x : SDL_AudioFormat) return C.int is
   begin
      return C.int (x and SDL_AUDIO_MASK_BITSIZE);
   end SDL_AUDIO_BITSIZE;

   function SDL_AUDIO_ISFLOAT (x : SDL_AudioFormat) return SDL_bool is
   begin
      if (x and SDL_AUDIO_MASK_DATATYPE) /= 0 then
         return SDL_TRUE;
      else
         return SDL_FALSE;
      end if;
   end SDL_AUDIO_ISFLOAT;

   function SDL_AUDIO_ISBIGENDIAN (x : SDL_AudioFormat) return SDL_bool is
   begin
      if (x and SDL_AUDIO_MASK_ENDIAN) /= 0 then
         return SDL_TRUE;
      else
         return SDL_FALSE;
      end if;
   end SDL_AUDIO_ISBIGENDIAN;

   function SDL_AUDIO_ISSIGNED (x : SDL_AudioFormat) return SDL_bool is
   begin
      if (x and SDL_AUDIO_MASK_SIGNED) /= 0 then
         return SDL_TRUE;
      else
         return SDL_FALSE;
      end if;
   end SDL_AUDIO_ISSIGNED;

   function SDL_AUDIO_ISINT (x : SDL_AudioFormat) return SDL_bool is
   begin
      if SDL_AUDIO_ISFLOAT (x) = SDL_FALSE then
         return SDL_TRUE;
      else
         return SDL_FALSE;
      end if;
   end SDL_AUDIO_ISINT;

   function SDL_AUDIO_ISLITTLEENDIAN (x : SDL_AudioFormat) return SDL_bool is
   begin
      if SDL_AUDIO_ISBIGENDIAN (x) = SDL_FALSE then
         return SDL_TRUE;
      else
         return SDL_FALSE;
      end if;
   end SDL_AUDIO_ISLITTLEENDIAN;

   function SDL_AUDIO_ISUNSIGNED (x : SDL_AudioFormat) return SDL_bool is
   begin
      if SDL_AUDIO_ISSIGNED (x) = SDL_FALSE then
         return SDL_TRUE;
      else
         return SDL_FALSE;
      end if;
   end SDL_AUDIO_ISUNSIGNED;

   function SDL_LoadWAV
     (file      : C.char_array;
      spec      : access SDL_AudioSpec;
      audio_buf : System.Address;
      audio_len : access Uint32) return access SDL_AudioSpec
   is
   begin
      return SDL_LoadWAV_RW
          (SDL_RWFromFile (file, C.To_C ("rb")),
           1,
           spec,
           audio_buf,
           audio_len);
   end SDL_LoadWAV;

end SDL;
