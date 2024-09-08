;; *************** Object_RAM.asm ***************
;; Object RAM export. Thursday, August 29, 2024 10:27:58 PM

TOTAL_MAX_OBJECTS = #$0d

Object_status .dsb 13
Object_x_lo .dsb 13
Object_x_hi .dsb 13
Object_screen .dsb 13
Object_y_lo .dsb 13
Object_y_hi .dsb 13
Object_h_speed_lo .dsb 13
Object_h_speed_hi .dsb 13
Object_v_speed_lo .dsb 13
Object_v_speed_hi .dsb 13
Object_id .dsb 13
Object_type .dsb 13
Object_frame .dsb 13
Object_direction .dsb 13
Object_animation_timer .dsb 13
Object_action_timer .dsb 13
Object_flags .dsb 13
Object_health .dsb 13
Object_vulnerability .dsb 13
