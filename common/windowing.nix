# Basic windowing controls
{ modifier }: let
        directions = [ "Left" "Right" "Up" "Down" ];
        tabs = builtins.genList (x: x) 10;
        bindNoMod = keys: action: { inherit keys action; };
        bind = keys: action: bindNoMod (modifier ++ keys) action;
    in {
        normal =
            # Move focus
            (map (direction:
                bind [ direction ] { type = "moveFocus"; inherit direction; }
            ) directions) ++
            # Move window
            (map (direction:
                bind [ "Shift" direction ] { type = "moveWindow"; inherit direction; }
            ) directions) ++
            # Move focus tab
            (map (tab:
                bind [ tab ] { type = "moveFocusTab"; inherit tab; }
            ) tabs) ++
            # Move window tab
            (map (tab:
                bind [ "Shift" tab ] { type = "moveWindowTab"; inherit tab; }
            ) tabs) ++
            [
                # Fullscreen
                (bind [ "f" ] { type = "fullscreen"; })
                # Kill focused
                (bind [ "Shift" "q" ] { type = "killFocused"; })
                # Modes
                (bind [ "r" ] { type = "mode"; mode = "resize"; })
            ];
        resize = [
            (bindNoMod [ "Left" ] { type = "resize"; axis = "width"; direction = "grow"; })
            (bindNoMod [ "Right" ] { type = "resize"; axis = "width"; direction = "shrink"; })
            (bindNoMod [ "Up" ] { type = "resize"; axis = "height"; direction = "shrink"; })
            (bindNoMod [ "Down" ] { type = "resize"; axis = "height"; direction = "grow"; })
            (bindNoMod [ "Escape" ] { type = "mode"; mode = "normal"; })
        ];
    }
