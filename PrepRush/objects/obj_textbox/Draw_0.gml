//if !setup exit;

accept_key = keyboard_check_pressed(vk_space);

textbox_x = camera_get_view_x(view_camera[0]);
textbox_y = camera_get_view_y(view_camera[0]) + 546;

//setup

if setup == false
	{
		
		setup = true;
		draw_set_font(global.font_main);
		draw_set_valign(fa_top);
		draw_set_halign(fa_left);
		
		// loop through pages
		//page_number = array_length(text);
		for (var p = 0; p < page_number; p++)
			{
				// finds out how many charcters are on each page and stores the number
				text_length[p] = string_length(text[p]);	
				
				// Get's x_position for textbox
					// character on the left
					text_x_offset[p] = 448;
					portrait_x_offset[p] = 158;
					
					// character on the right
					if speaker_side[p] == -1
						{
							text_x_offset[p] = 228;
							portrait_x_offset = 1024;
						}
					
					//No character, centers textbox
					if speaker_sprite[p] == noone
						{
							text_x_offset[p] = 347;
						}
					
				
				
				// Getting individual characters and finding where the lines of text should break 
				for (var c = 0; c < text_length[p]; c++)
				{
					
					var _char_pos = c + 1;
					
					//Stores individual characters into the char array
					char[c, p] = string_char_at(text[p], _char_pos);
					
					
					// get current width of the line
					var _txt_up_to_char = string_copy(text[p], 1, _char_pos )
					var _current_txt_w = string_width(_txt_up_to_char) - string_width(char[c, p]) ;
					
					//get last free space
					if char[c, p] == "" {last_free_space = _char_pos + 1};
					
					// get the line breaks
					if _current_txt_w  - line_break_offset[p] > line_width
						{ 
						line_break_pos[ line_break_num[p] , p ] = last_free_space;
						line_break_num[p]++;
						var _txt_up_to_last_space = string_copy( text[p], 1, last_free_space);
						var _last_free_space_string = string_char_at( text[p], last_free_space );
						line_break_offset[p] = string_width( _txt_up_to_last_space ) - string_width (_last_free_space_string );
		
						}
					
				}
				
			//getting each charcters coordinates 
			for (var c = 0; c < text_length[p]; c++)
				{
					var _char_pos = c + 1;
					var _txt_x = textbox_x + text_x_offset[p] + border;
					var _txt_y = textbox_y + border;
					
					// get current width of line
					var _txt_up_to_char = string_copy( text[p], 1, _char_pos)
					var _current_txt_w = string_width(_txt_up_to_char) - string_width(char[c, p]);
					var _txt_line = 0;
					
					//compensate for sting breaks
					for (var lb = 0; lb < line_break_num[p]; lb++)
						{
							
							if _char_pos >= line_break_pos[lb, p]
								{
								var _str_copy = string_copy( text[p], line_break_pos[lb, p], _char_pos - line_break_pos[lb, p] )
								_current_txt_w = string_width( _str_copy );
							
								//record the line this chracter should be on
								_txt_line = lb+1;// +1 beacause line break(lb) starts at 0
								}
						}
						
					// add to the x amd y coordinates based on the new info
			char_x[c, p] = _txt_x + _current_txt_w;
			char_y[c, p] = _txt_y + _txt_line * line_sep;
				
				}
				
			
			}
			
			
	}




//-----------------------------typing the text
if text_pause_timer <= 0
	{
		
		
	if draw_char < text_length[page]
		{
			draw_char += text_speed;
			draw_char = clamp(draw_char, 0, text_length[page]);
			var _check_char = string_char_at(text[page], draw_char);
			if _check_char == "." || _check_char == "?" || _check_char == ","
				{
					text_pause_timer = text_pause_time;
					if (!audio_is_playing(snd[page]))
						audio_play_sound(snd[page], 8, false);
				}
				else
				{
					if snd_count < snd_delay
					{
						snd_count ++;
					} else {
					snd_count = 0;
					audio_play_sound(snd[page], 8, false);
					}
				}
				
		}
} else {
	
	text_pause_timer--
	
}

//---------------------flip through pages
if accept_key
	{
		//if done, goto next page
		if draw_char == text_length[page]
			{
				
				//next page
				if page < page_number - 1
					{
						page++;
						draw_char = 0;
					}
				else
					{
						//link text for options
						if option_number > 0
						{
							create_textbox(option_link_id[option_pos]);
						}
						instance_destroy();
					}
					
			}
			// Not done typing
			else
				{
					draw_char = text_length[page]
				}
				
	}



//--------------------draw text box
var _textb_x = textbox_x + text_x_offset[page];
var _textb_y = textbox_y;
textb_img += textb_img_spd;
textb_spr_w = sprite_get_width(textb_spr[page]);
textb_spr_h = sprite_get_height(textb_spr[page]);
// draw the speaker
if speaker_sprite[page] != noone
	{
		sprite_index = speaker_sprite[page];
		var _speaker_x = textbox_x + portrait_x_offset[page];
		if speaker_side[page] == -1 {_speaker_x += sprite_width + 850};
		
		//draw speaker box
		if speaker_side[page] != -1 {draw_sprite_ext(textb_spr[page], textb_img, textbox_x + portrait_x_offset[page] + 85, textbox_y, sprite_width/textb_spr_w + 0.35 , sprite_height/textb_spr_h +0.35, 0, c_white, 1);}
		else {draw_sprite_ext(textb_spr[page], textb_img, textbox_x + portrait_x_offset[page] + 923, textbox_y, sprite_width/textb_spr_w + 0.45 , sprite_height/textb_spr_h +0.35, 0, c_white, 1);}
		draw_sprite_ext(sprite_index, image_index, _speaker_x + 95, textbox_y + 8, speaker_side[page], 1, 0, c_white, 1);
	}
// back of the textbox
draw_sprite_ext(textb_spr[page], textb_img,  _textb_x,  _textb_y, textbox_width / textb_spr_w, textbox_height / textb_spr_h, 0, c_white, 1);


//-------------------options
if draw_char == text_length[page] && page == page_number - 1
	{
		
		//Option Selection
		option_pos += keyboard_check_pressed(vk_down) - keyboard_check_pressed(vk_up);
		option_pos = clamp(option_pos, 0, option_number - 1); 
		
		var _op_space = 50;
		var _op_bord = 16
		for (var op = 0; op < option_number; op++)
			{
				// option box
				var _o_w = string_width(option[op]) + _op_bord * 2;
				draw_sprite_ext(textb_spr[page], textb_img, _textb_x + 34, _textb_y - _op_space * option_number + _op_space*op, _o_w / textb_spr_w, (_op_space-1)/ textb_spr_h, 0, c_white, 1);
				
				//the arrow
				if option_pos == op
					{
						draw_sprite(sPointer, 0, _textb_x +59,  _textb_y - _op_space * option_number + _op_space*op + 28)
					}
				
				//Option Text
				draw_text(_textb_x + 34 + _op_bord, _textb_y - _op_space * option_number + _op_space*op + 10, option[op]);
			}
	}

// Draw the text
for (var c = 0; c < draw_char; c++)
	{
		//The text
		//draw_text( char_x[c, page], char_y[c, page], char[c, page]);
		var _drawtext = string_copy(text[page], 1, draw_char);
		draw_text_ext(_textb_x + border, _textb_y + border, _drawtext, line_sep, line_width);
	}