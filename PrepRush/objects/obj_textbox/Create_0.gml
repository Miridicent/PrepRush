depth = -9999;


//textbox paramaters
textbox_width = 576;
textbox_height = 226;
border = 16;
line_sep = 29;
line_width = textbox_width - border*2;
textb_spr[0] = spr_textbox;
textb_img = 0;
textb_img_spd = 6/60;

//text
page = 0;
page_number = 0;
text[0] = "";
text_length[0] = string_length(text[0]);



char[0, 0] = "";
char_x[0, 0] = 0;
char_y[0, 0] = 0;


draw_char = 0;
text_speed = 1;
//Options
option[0] = "";
option_link_id[0] = -1;
option_pos = 0;
option_number = 0;

setup = false;

//sound
snd_delay = 4;
snd_count = snd_delay;

//effects
scr_set_defaults_for_text();
last_free_space = 0;
text_pause_timer = 0;
text_pause_time = 16;