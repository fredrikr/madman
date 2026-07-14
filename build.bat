@REM Note: These variable values can include a path (absolute or relative)
@SETLOCAL
@SET ruby=ruby
@SET compiler=..\PunyInform\inform6.exe
@SET nailbin=..\nail\bin
@SET naillib=..\nail\lib
@SET dictionary=generated_dictionary.h
@SET source1=game.inf
@SET source2=%naillib%\parser.h
@SET source3=grammar.inf
@SET outfile=game.z3
@SET debug_outfile=game_debug.z3

%ruby% %nailbin%\build_dictionary.rb %dictionary% %source1% %source2% %source3%
@if %errorlevel% neq 0 exit /b %errorlevel%

%ruby% %nailbin%\transform_code.rb %dictionary% %source1% %source2% %source3%
@if %errorlevel% neq 0 exit /b %errorlevel%

%compiler% $OMIT_SYMBOL_TABLE=0 -Cu -v3eD +%naillib% $#RUNTIME_ERRORS=2 %1 %2 %3 %4 %5 generated_%source1% %debug_outfile%
@if %errorlevel% neq 0 exit /b %errorlevel%

%compiler% $OMIT_SYMBOL_TABLE=1 -Cu -v3es +%naillib% $#RUNTIME_ERRORS=0 %1 %2 %3 %4 %5 generated_%source1% %outfile%

@ENDLOCAL
