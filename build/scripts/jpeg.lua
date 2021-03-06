-------------------------------------------------------------------------------
-- jpeg.lua
--
-- References were used from Andrew Mac's Torque6 engine, which is under
-- the same license (MIT)
-- https://github.com/andr3wmac/Torque6
-- Copyright (c) 2015 Andrew Mac
--
-- Copyright (c) 2015 Jeff Hutchinson
-- Copyright (c) 2015 Adric Blake
--
-- Permission is hereby granted, free of charge, to any person obtaining a copy
-- of this software and associated documentation files (the "Software"), to
-- deal in the Software without restriction, including without limitation the
-- rights to use, copy, modify, merge, publish, distribute, sublicense, and/or
-- sell copies of the Software, and to permit persons to whom the Software is
-- furnished to do so, subject to the following conditions:
--
-- The above copyright notice and this permission notice shall be included in
-- all copies or substantial portions of the Software.
--
-- THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
-- IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
-- FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
-- AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
-- LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
-- FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
-- IN THE SOFTWARE.
-------------------------------------------------------------------------------

project "JPEG"
   targetname "JPEG"
   language "C++"
   kind "StaticLib"
   targetdir (BUILD_LOCATION .. "/bin")

   includedirs {
      "../../engine/lib/ljpeg",
   }

   files {
      "../../engine/lib/ljpeg/*.h",
      "../../engine/lib/ljpeg/*.c",
   }

   removefiles {
      "../../engine/lib/ljpeg/extras/**",
      "../../engine/lib/ljpeg/**.mac.*",
      "../../engine/lib/ljpeg/**.linux.*",
      "../../engine/lib/ljpeg/**.cw.*",
      "../../engine/lib/ljpeg/**.win.*",
      "../../engine/lib/ljpeg/jmemansi.c",
      "../../engine/lib/ljpeg/jmemdos.c",
      "../../engine/lib/ljpeg/jmemmac.c",
      "../../engine/lib/ljpeg/jmemname.c",
      "../../engine/lib/ljpeg/jpegtran.c",
   }

   -- Platform specific files for visual studio
   configuration "vs*"
      files {
         "../../engine/lib/ljpeg/jconfig.vc.win.h"
      }
      defines { "_CRT_SECURE_NO_WARNINGS" }
      flags   { "NoNativeWChar", "StaticRuntime" }

   -- Platform specific files for gcc/llvm/clang
   configuration "macosx or linux or bsd or gmake or mingw*"
      files {
         "../../engine/lib/ljpeg/jconfig.gcc.linux.h"
      }

   configuration "Debug"
      flags   { "Symbols" }

   configuration "windows"
      links { "ole32" }

   configuration "linux"
      links { "dl" }

   configuration { "macosx", "gmake" }
      buildoptions {"-mmacosx-version-min=10.4" }
      linkoptions  {"-mmacosx-version-min=10.4" }