//script textbox functions 

function scr_set_defaults_for_text()
{
	line_break_pos[0, page_number] = 999;
	line_break_num[page_number] = 0;
	line_break_offset[page_number] = 0;
	
	textb_spr[page_number] = spr_textbox;
	speaker_sprite[page_number] = noone;
	speaker_side[page_number] = 1;
	snd[page_number] = Default_Text_Sound2;
}

// @param text
	function scr_text(_text){
		
	scr_set_defaults_for_text()
	
	text[page_number] = _text;
	
	//if argument_count > 1
	//	{
	//		switch(argument[1])
	//		{
	//			case "Mc":
	//			speaker_sprite[page_number] = Mc_portrait;
	//			textb_spr[page_number] = spr_Mc_box;
	//			break;
				
	//			case "Mc-conf":
	//			speaker_sprite[page_number] = Mc_portrait_confused;
	//			textb_spr[page_number] = spr_Mc_box;
	//			//speaker__side[page_number] = -1;
	//			break;
				
	//			case "Mc-anno":
	//			speaker_sprite[page_number] =  Mc_portrait_annoyed;
	//			textb_spr[page_number] = spr_Mc_box;
	//			break;
				
	//			case "Mc-hapy":
	//			speaker_sprite[page_number] =  Mc_portrait_happy;
	//			textb_spr[page_number] = spr_Mc_box;
	//			break;
				
	//			case "Teach":
	//			speaker_sprite[page_number] = Teacher_portrait;
	//			textb_spr[page_number] = spr_Mc_box;
	//			break;
				
	//			case "Teach-angy":
	//			speaker_sprite[page_number] = Teacher_portrait_angy;
	//			textb_spr[page_number] = spr_Mc_box;
	//			break;
				
	//			case "Red":
	//			speaker_sprite[page_number] = RedGirl_portrait;
	//			textb_spr[page_number] = spr_Mc_box;
	//			break;
				
	//			case "Red-exap":
	//			speaker_sprite[page_number] = RedGirl_portrait_exasp;
	//			textb_spr[page_number] = spr_Mc_box;
	//			break;
				
	//			case "Blue":
	//			speaker_sprite[page_number] = BlueBoy_portrait;
	//			textb_spr[page_number] = spr_Mc_box;
	//			break;
				
	//			case "Blue-hapy":
	//			speaker_sprite[page_number] = BlueBoy_portrait_hapy;
	//			textb_spr[page_number] = spr_Mc_box;
	//			break;
				
	//			case "Orb":
	//			speaker_sprite[page_number] = Orb_portrait;
	//			textb_spr[page_number] = spr_Mc_box;
	//			break;
	//		}
	//	}
	
	//if argument_count > 2
	//	{
	//		speaker_side[page_number] = argument[2];
	//	}
	

	page_number++

}

//param option
//param link_id
function scr_option(_option, _link_id){
	option[option_number] = _option;
	option_link_id[option_number] = _link_id;
	
	option_number++;
}

//param text_id
function create_textbox(_text_id)
{
	with (instance_create_depth(0, 0, -9999, obj_textbox))
		{
			scr_game_text(_text_id);
		}
}

function destory_textbox()
{
	if (object_exists(obj_textbox))
	{
		instance_deactivate_object(obj_textbox);
	}
}