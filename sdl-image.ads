package SDL.Image is

   SDL_IMAGE_MAJOR_VERSION : constant Uint8 := 2;
   SDL_IMAGE_MINOR_VERSION : constant Uint8 := 0;
   SDL_IMAGE_PATCHLEVEL    : constant Uint8 := 0;

   procedure SDL_IMAGE_VERSION (X : access SDL_version);
   pragma Inline (SDL_IMAGE_VERSION);

   function IMG_Linked_Version return SDL_version;
   pragma Import (C, IMG_Linked_Version, "IMG_Linked_Version");

   subtype IMG_InitFlags is C.unsigned;
   IMG_INIT_JPG  : constant IMG_InitFlags := 16#00000001#;
   IMG_INIT_PNG  : constant IMG_InitFlags := 16#00000002#;
   IMG_INIT_TIF  : constant IMG_InitFlags := 16#00000004#;
   IMG_INIT_WEBP : constant IMG_InitFlags := 16#00000008#;

   function IMG_Init (flags : C.int) return C.int;
   pragma Import (C, IMG_Init, "IMG_Init");

   procedure IMG_Quit;
   pragma Import (C, IMG_Quit, "IMG_Quit");

   function IMG_LoadTyped_RW
     (src     : access SDL_RWops;
      freesrc : C.int;
      kind    : C.char_array) return access SDL_Surface;
   pragma Import (C, IMG_LoadTyped_RW, "IMG_LoadTyped_RW");

   function IMG_Load (file : C.char_array) return access SDL_Surface;
   pragma Import (C, IMG_Load, "IMG_Load");

   function IMG_Load_RW
     (src     : access SDL_RWops;
      freesrc : C.int) return access SDL_Surface;
   pragma Import (C, IMG_Load_RW, "IMG_Load_RW");

   function IMG_LoadTexture
     (renderer : access SDL_Renderer;
      file     : C.char_array) return access SDL_Texture;
   pragma Import (C, IMG_LoadTexture, "IMG_LoadTexture");

   function IMG_LoadTexture_RW
     (renderer : access SDL_Renderer;
      src      : access SDL_RWops;
      freesrc  : C.int) return access SDL_Texture;
   pragma Import (C, IMG_LoadTexture_RW, "IMG_LoadTexture_RW");

   function IMG_LoadTextureTyped_RW
     (renderer : access SDL_Renderer;
      src      : access SDL_RWops;
      freesrc  : C.int;
      kind     : C.char_array) return access SDL_Texture;
   pragma Import (C, IMG_LoadTextureTyped_RW, "IMG_LoadTextureTyped_RW");

   function IMG_isICO (src : access SDL_RWops) return C.int;
   pragma Import (C, IMG_isICO, "IMG_isICO");

   function IMG_isCUR (src : access SDL_RWops) return C.int;
   pragma Import (C, IMG_isCUR, "IMG_isCUR");

   function IMG_isBMP (src : access SDL_RWops) return C.int;
   pragma Import (C, IMG_isBMP, "IMG_isBMP");

   function IMG_isGIF (src : access SDL_RWops) return C.int;
   pragma Import (C, IMG_isGIF, "IMG_isGIF");

   function IMG_isJPG (src : access SDL_RWops) return C.int;
   pragma Import (C, IMG_isJPG, "IMG_isJPG");

   function IMG_isLBM (src : access SDL_RWops) return C.int;
   pragma Import (C, IMG_isLBM, "IMG_isLBM");

   function IMG_isPCX (src : access SDL_RWops) return C.int;
   pragma Import (C, IMG_isPCX, "IMG_isPCX");

   function IMG_isPNG (src : access SDL_RWops) return C.int;
   pragma Import (C, IMG_isPNG, "IMG_isPNG");

   function IMG_isPNM (src : access SDL_RWops) return C.int;
   pragma Import (C, IMG_isPNM, "IMG_isPNM");

   function IMG_isTIF (src : access SDL_RWops) return C.int;
   pragma Import (C, IMG_isTIF, "IMG_isTIF");

   function IMG_isXCF (src : access SDL_RWops) return C.int;
   pragma Import (C, IMG_isXCF, "IMG_isXCF");

   function IMG_isXPM (src : access SDL_RWops) return C.int;
   pragma Import (C, IMG_isXPM, "IMG_isXPM");

   function IMG_isXV (src : access SDL_RWops) return C.int;
   pragma Import (C, IMG_isXV, "IMG_isXV");

   function IMG_isWEBP (src : access SDL_RWops) return C.int;
   pragma Import (C, IMG_isWEBP, "IMG_isWEBP");

   function IMG_LoadICO_RW (src : access SDL_RWops) return access SDL_Surface;
   pragma Import (C, IMG_LoadICO_RW, "IMG_LoadICO_RW");

   function IMG_LoadCUR_RW (src : access SDL_RWops) return access SDL_Surface;
   pragma Import (C, IMG_LoadCUR_RW, "IMG_LoadCUR_RW");

   function IMG_LoadBMP_RW (src : access SDL_RWops) return access SDL_Surface;
   pragma Import (C, IMG_LoadBMP_RW, "IMG_LoadBMP_RW");

   function IMG_LoadGIF_RW (src : access SDL_RWops) return access SDL_Surface;
   pragma Import (C, IMG_LoadGIF_RW, "IMG_LoadGIF_RW");

   function IMG_LoadJPG_RW (src : access SDL_RWops) return access SDL_Surface;
   pragma Import (C, IMG_LoadJPG_RW, "IMG_LoadJPG_RW");

   function IMG_LoadLBM_RW (src : access SDL_RWops) return access SDL_Surface;
   pragma Import (C, IMG_LoadLBM_RW, "IMG_LoadLBM_RW");

   function IMG_LoadPCX_RW (src : access SDL_RWops) return access SDL_Surface;
   pragma Import (C, IMG_LoadPCX_RW, "IMG_LoadPCX_RW");

   function IMG_LoadPNG_RW (src : access SDL_RWops) return access SDL_Surface;
   pragma Import (C, IMG_LoadPNG_RW, "IMG_LoadPNG_RW");

   function IMG_LoadPNM_RW (src : access SDL_RWops) return access SDL_Surface;
   pragma Import (C, IMG_LoadPNM_RW, "IMG_LoadPNM_RW");

   function IMG_LoadTGA_RW (src : access SDL_RWops) return access SDL_Surface;
   pragma Import (C, IMG_LoadTGA_RW, "IMG_LoadTGA_RW");

   function IMG_LoadTIF_RW (src : access SDL_RWops) return access SDL_Surface;
   pragma Import (C, IMG_LoadTIF_RW, "IMG_LoadTIF_RW");

   function IMG_LoadXCF_RW (src : access SDL_RWops) return access SDL_Surface;
   pragma Import (C, IMG_LoadXCF_RW, "IMG_LoadXCF_RW");

   function IMG_LoadXPM_RW (src : access SDL_RWops) return access SDL_Surface;
   pragma Import (C, IMG_LoadXPM_RW, "IMG_LoadXPM_RW");

   function IMG_LoadXV_RW (src : access SDL_RWops) return access SDL_Surface;
   pragma Import (C, IMG_LoadXV_RW, "IMG_LoadXV_RW");

   function IMG_LoadWEBP_RW (src : access SDL_RWops) return access SDL_Surface;
   pragma Import (C, IMG_LoadWEBP_RW, "IMG_LoadWEBP_RW");

   function IMG_ReadXPMFromArray
     (xpm : System.Address) return access SDL_Surface;
   pragma Import (C, IMG_ReadXPMFromArray, "IMG_ReadXPMFromArray");

   function IMG_SavePNG
     (surface : access SDL_Surface;
      file    : C.char_array) return C.int;
   pragma Import (C, IMG_SavePNG, "IMG_SavePNG");

   function IMG_SavePNG_RW
     (surface : access SDL_Surface;
      dst     : access SDL_RWops;
      freedst : C.int) return C.int;
   pragma Import (C, IMG_SavePNG_RW, "IMG_SavePNG_RW");

   procedure IMG_SetError (text : C.char_array) renames SDL_SetError;
   function IMG_GetError return C.Strings.chars_ptr renames SDL_GetError;

end SDL.Image;
