function [ in ] = norm01( in )
    in = in - min(in);
    in = in / max(in);
end

