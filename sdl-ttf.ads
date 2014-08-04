package SDL.TTF is

   SDL_TTF_MAJOR_VERSION : constant Uint8 := 2;
   SDL_TTF_MINOR_VERSION : constant Uint8 := 0;
   SDL_TTF_PATCHLEVEL    : constant Uint8 := 12;

   TTF_MAJOR_VERSION : constant Uint8 := SDL_TTF_MAJOR_VERSION;
   TTF_MINOR_VERSION : constant Uint8 := SDL_TTF_MINOR_VERSION;
   TTF_PATCHLEVEL    : constant Uint8 := SDL_TTF_PATCHLEVEL;

   procedure SDL_TTF_VERSION (X : access SDL_version);
   pragma Inline (SDL_TTF_VERSION);
   
   procedure TTF_VERSION (X : access SDL_version) renames SDL_TTF_VERSION;

   UNICODE_BOM_NATIVE  : constant := 16#FEFF#;
   UNICODE_BOM_SWAPPED : constant := 16#FFFE#;

   TTF_STYLE_NORMAL        : constant := 16#00#;
   TTF_STYLE_BOLD          : constant := 16#01#;
   TTF_STYLE_ITALIC        : constant := 16#02#;
   TTF_STYLE_UNDERLINE     : constant := 16#04#;
   TTF_STYLE_STRIKETHROUGH : constant := 16#08#;

   TTF_HINTING_NORMAL : constant := 0;
   TTF_HINTING_LIGHT  : constant := 1;
   TTF_HINTING_MONO   : constant := 2;
   TTF_HINTING_NONE   : constant := 3;

   subtype TTF_Font is System.Address;

   function TTF_Linked_Version return SDL_version;
   pragma Import (C, TTF_Linked_Version, "TTF_Linked_Version");

   procedure TTF_ByteSwappedUNICODE (swapped : C.int);
   pragma Import (C, TTF_ByteSwappedUNICODE, "TTF_ByteSwappedUNICODE");

   function TTF_Init return C.int;
   pragma Import (C, TTF_Init, "TTF_Init");

   function TTF_OpenFont
     (file   : C.char_array;
      ptsize : C.int) return access TTF_Font;
   pragma Import (C, TTF_OpenFont, "TTF_OpenFont");

   function TTF_OpenFontIndex
     (file   : C.char_array;
      ptsize : C.int;
      index  : C.long) return access TTF_Font;
   pragma Import (C, TTF_OpenFontIndex, "TTF_OpenFontIndex");

   function TTF_OpenFontRW
     (src     : access SDL_RWops;
      freesrc : C.int;
      ptsize  : C.int) return access TTF_Font;
   pragma Import (C, TTF_OpenFontRW, "TTF_OpenFontRW");

   function TTF_OpenFontIndexRW
     (src     : access SDL_RWops;
      freesrc : C.int;
      ptsize  : C.int;
      index   : C.long) return access TTF_Font;
   pragma Import (C, TTF_OpenFontIndexRW, "TTF_OpenFontIndexRW");

   function TTF_GetFontStyle (font : access TTF_Font) return C.int;
   pragma Import (C, TTF_GetFontStyle, "TTF_GetFontStyle");

   procedure TTF_SetFontStyle (font : access TTF_Font; style : C.int);
   pragma Import (C, TTF_SetFontStyle, "TTF_SetFontStyle");

   function TTF_GetFontOutline (font : access TTF_Font) return C.int;
   pragma Import (C, TTF_GetFontOutline, "TTF_GetFontOutline");

   procedure TTF_SetFontOutline (font : access TTF_Font; outline : C.int);
   pragma Import (C, TTF_SetFontOutline, "TTF_SetFontOutline");

   function TTF_GetFontHinting (font : access TTF_Font) return C.int;
   pragma Import (C, TTF_GetFontHinting, "TTF_GetFontHinting");

   procedure TTF_SetFontHinting (font : access TTF_Font; hinting : C.int);
   pragma Import (C, TTF_SetFontHinting, "TTF_SetFontHinting");

   function TTF_FontHeight (font : access TTF_Font) return C.int;
   pragma Import (C, TTF_FontHeight, "TTF_FontHeight");

   function TTF_FontAscent (font : access TTF_Font) return C.int;
   pragma Import (C, TTF_FontAscent, "TTF_FontAscent");

   function TTF_FontDescent (font : access TTF_Font) return C.int;
   pragma Import (C, TTF_FontDescent, "TTF_FontDescent");

   function TTF_FontLineSkip (font : access TTF_Font) return C.int;
   pragma Import (C, TTF_FontLineSkip, "TTF_FontLineSkip");

   function TTF_GetFontKerning (font : access TTF_Font) return C.int;
   pragma Import (C, TTF_GetFontKerning, "TTF_GetFontKerning");

   procedure TTF_SetFontKerning (font : access TTF_Font; allowed : C.int);
   pragma Import (C, TTF_SetFontKerning, "TTF_SetFontKerning");

   function TTF_FontFaces (font : access TTF_Font) return C.long;
   pragma Import (C, TTF_FontFaces, "TTF_FontFaces");

   function TTF_FontFaceIsFixedWidth (font : access TTF_Font) return C.int;
   pragma Import (C, TTF_FontFaceIsFixedWidth, "TTF_FontFaceIsFixedWidth");

   function TTF_FontFaceFamilyName
     (font : access TTF_Font) return C.Strings.chars_ptr;
   pragma Import (C, TTF_FontFaceFamilyName, "TTF_FontFaceFamilyName");

   function TTF_FontFaceStyleName
     (font : access TTF_Font) return C.Strings.chars_ptr;
   pragma Import (C, TTF_FontFaceStyleName, "TTF_FontFaceStyleName");

   function TTF_GlyphIsProvided
     (font : access TTF_Font;
      ch   : Uint16) return C.int;
   pragma Import (C, TTF_GlyphIsProvided, "TTF_GlyphIsProvided");

   function TTF_GlyphMetrics
     (font    : access TTF_Font;
      ch      : Uint16;
      minx    : access C.int;
      maxx    : access C.int;
      miny    : access C.int;
      maxy    : access C.int;
      advance : access C.int) return C.int;
   pragma Import (C, TTF_GlyphMetrics, "TTF_GlyphMetrics");

   function TTF_SizeText
     (font : access TTF_Font;
      text : C.char_array;
      w    : access C.int;
      h    : access C.int) return C.int;
   pragma Import (C, TTF_SizeText, "TTF_SizeText");

   function TTF_SizeUTF8
     (font : access TTF_Font;
      text : C.char_array;
      w    : access C.int;
      h    : access C.int) return C.int;
   pragma Import (C, TTF_SizeUTF8, "TTF_SizeUTF8");

   function TTF_SizeUNICODE
     (font : access TTF_Font;
      text : access Uint16;
      w    : access C.int;
      h    : access C.int) return C.int;
   pragma Import (C, TTF_SizeUNICODE, "TTF_SizeUNICODE");

   function TTF_RenderText_Solid
     (font : access TTF_Font;
      text : C.char_array;
      fg   : SDL_Color) return access SDL_Surface;
   pragma Import (C, TTF_RenderText_Solid, "TTF_RenderText_Solid");

   function TTF_RenderUTF8_Solid
     (font : access TTF_Font;
      text : C.char_array;
      fg   : SDL_Color) return access SDL_Surface;
   pragma Import (C, TTF_RenderUTF8_Solid, "TTF_RenderUTF8_Solid");

   function TTF_RenderUNICODE_Solid
     (font : access TTF_Font;
      text : access Uint16;
      fg   : SDL_Color) return access SDL_Surface;
   pragma Import (C, TTF_RenderUNICODE_Solid, "TTF_RenderUNICODE_Solid");

   function TTF_RenderGlyph_Solid
     (font : access TTF_Font;
      ch   : Uint16;
      fg   : SDL_Color) return access SDL_Surface;
   pragma Import (C, TTF_RenderGlyph_Solid, "TTF_RenderGlyph_Solid");

   function TTF_RenderText_Shaded
     (font : access TTF_Font;
      text : C.char_array;
      fg   : SDL_Color;
      bg   : SDL_Color) return access SDL_Surface;
   pragma Import (C, TTF_RenderText_Shaded, "TTF_RenderText_Shaded");

   function TTF_RenderText
     (font : access TTF_Font;
      text : C.char_array;
      fg   : SDL_Color;
      bg   : SDL_Color) return access SDL_Surface renames
     TTF_RenderText_Shaded;

   function TTF_RenderUTF8_Shaded
     (font : access TTF_Font;
      text : C.char_array;
      fg   : SDL_Color;
      bg   : SDL_Color) return access SDL_Surface;
   pragma Import (C, TTF_RenderUTF8_Shaded, "TTF_RenderUTF8_Shaded");

   function TTF_RenderUTF8
     (font : access TTF_Font;
      text : C.char_array;
      fg   : SDL_Color;
      bg   : SDL_Color) return access SDL_Surface renames
     TTF_RenderUTF8_Shaded;

   function TTF_RenderUNICODE_Shaded
     (font : access TTF_Font;
      text : access Uint16;
      fg   : SDL_Color;
      bg   : SDL_Color) return access SDL_Surface;
   pragma Import (C, TTF_RenderUNICODE_Shaded, "TTF_RenderUNICODE_Shaded");

   function TTF_RenderUNICODE
     (font : access TTF_Font;
      text : access Uint16;
      fg   : SDL_Color;
      bg   : SDL_Color) return access SDL_Surface renames
     TTF_RenderUNICODE_Shaded;

   function TTF_RenderGlyph_Shaded
     (font : access TTF_Font;
      ch   : Uint16;
      fg   : SDL_Color;
      bg   : SDL_Color) return access SDL_Surface;
   pragma Import (C, TTF_RenderGlyph_Shaded, "TTF_RenderGlyph_Shaded");

   function TTF_RenderText_Blended
     (font : access TTF_Font;
      text : C.char_array;
      fg   : SDL_Color) return access SDL_Surface;
   pragma Import (C, TTF_RenderText_Blended, "TTF_RenderText_Blended");

   function TTF_RenderUTF8_Blended
     (font : access TTF_Font;
      text : C.char_array;
      fg   : SDL_Color) return access SDL_Surface;
   pragma Import (C, TTF_RenderUTF8_Blended, "TTF_RenderUTF8_Blended");

   function TTF_RenderUNICODE_Blended
     (font : access TTF_Font;
      text : access Uint16;
      fg   : SDL_Color) return access SDL_Surface;
   pragma Import (C, TTF_RenderUNICODE_Blended, "TTF_RenderUNICODE_Blended");

   function TTF_RenderText_Blended_Wrapped
     (font       : access TTF_Font;
      text       : C.char_array;
      fg         : SDL_Color;
      wrapLength : Uint32) return access SDL_Surface;
   pragma Import
     (C,
      TTF_RenderText_Blended_Wrapped,
      "TTF_RenderText_Blended_Wrapped");

   function TTF_RenderUTF8_Blended_Wrapped
     (font       : access TTF_Font;
      text       : C.char_array;
      fg         : SDL_Color;
      wrapLength : Uint32) return access SDL_Surface;
   pragma Import
     (C,
      TTF_RenderUTF8_Blended_Wrapped,
      "TTF_RenderUTF8_Blended_Wrapped");

   function TTF_RenderUNICODE_Blended_Wrapped
     (font       : access TTF_Font;
      text       : access Uint16;
      fg         : SDL_Color;
      wrapLength : Uint32) return access SDL_Surface;
   pragma Import
     (C,
      TTF_RenderUNICODE_Blended_Wrapped,
      "TTF_RenderUNICODE_Blended_Wrapped");

   function TTF_RenderGlyph_Blended
     (font : access TTF_Font;
      ch   : Uint16;
      fg   : SDL_Color) return access SDL_Surface;
   pragma Import (C, TTF_RenderGlyph_Blended, "TTF_RenderGlyph_Blended");

   procedure TTF_CloseFont (font : access TTF_Font);
   pragma Import (C, TTF_CloseFont, "TTF_CloseFont");

   procedure TTF_Quit;
   pragma Import (C, TTF_Quit, "TTF_Quit");

   function TTF_WasInit return C.int;
   pragma Import (C, TTF_WasInit, "TTF_WasInit");

   function TTF_GetFontKerningSize
     (font       : access TTF_Font;
      prev_index : C.int;
      index      : C.int) return C.int;
   pragma Import (C, TTF_GetFontKerningSize, "TTF_GetFontKerningSize");

   procedure TTF_SetError (text : C.char_array) renames SDL_SetError;
   function TTF_GetError return C.Strings.chars_ptr renames SDL_GetError;

end SDL.TTF;
