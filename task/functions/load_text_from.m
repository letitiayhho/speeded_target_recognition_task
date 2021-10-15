function [txt] = load_text_from(fpath)
    txt = importdata(fpath);
    txt = strjoin(txt, '\n');
end