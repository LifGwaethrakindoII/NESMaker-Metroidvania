song_index_XCellBattery = 0
song_XCellBattery = 0

sfx_index_sfx_thump = 0
sfx_thump = 0
sfx_index_sfx_noteDead = 1
sfx_noteDead  = 1
sfx_index_sfx_noteLife = 2
sfx_noteLive  = 2

song_list:
	.dw XCellBattery

sfx_list:
	.dw _sfx_thump
.dw _sfx_noteDead
.dw _sfx_noteLive

instrument_list:
	.dw Instrument1_0
	.dw Instrument2_1
	.dw Instrument3_2
	.dw Instrument5_3
	.dw Silent_4

Instrument1_0:
	.db 5, 9, 11, 13, ARP_TYPE_ABSOLUTE
	.db 14,10,10,ENV_STOP
	.db 0,ENV_STOP
	.db 192,DUTY_ENV_STOP
	.db ENV_STOP
Instrument2_1:
	.db 5, 9, 11, 13, ARP_TYPE_ABSOLUTE
	.db 11,11,11,ENV_STOP
	.db 0,ENV_STOP
	.db 64,DUTY_ENV_STOP
	.db ENV_STOP
Instrument3_2:
	.db 5, 7, 9, 11, ARP_TYPE_ABSOLUTE
	.db 0,ENV_STOP
	.db 0,ENV_STOP
	.db 64,DUTY_ENV_STOP
	.db ENV_STOP
Instrument5_3:
	.db 5, 7, 9, 11, ARP_TYPE_ABSOLUTE
	.db 0,ENV_STOP
	.db 0,ENV_STOP
	.db 0,DUTY_ENV_STOP
	.db ENV_STOP
Silent_4:
	.db 5, 7, 9, 11, ARP_TYPE_ABSOLUTE
	.db 0,ENV_STOP
	.db 0,ENV_STOP
	.db 0,DUTY_ENV_STOP
	.db ENV_STOP

XCellBattery:
	.db 0
	.db 1
	.db 213
	.db 0
	.dw XCellBattery_square1
	.dw XCellBattery_square2
	.dw XCellBattery_triangle
	.dw XCellBattery_noise
	.dw 0

XCellBattery_square1:
	.db CAL,<(XCellBattery_square1_0),>(XCellBattery_square1_0)
	.db CAL,<(XCellBattery_square1_1),>(XCellBattery_square1_1)
	.db CAL,<(XCellBattery_square1_2),>(XCellBattery_square1_2)
	.db CAL,<(XCellBattery_square1_3),>(XCellBattery_square1_3)
	.db CAL,<(XCellBattery_square1_0),>(XCellBattery_square1_0)
	.db CAL,<(XCellBattery_square1_1),>(XCellBattery_square1_1)
	.db CAL,<(XCellBattery_square1_2),>(XCellBattery_square1_2)
	.db CAL,<(XCellBattery_square1_3),>(XCellBattery_square1_3)
	.db CAL,<(XCellBattery_square1_4),>(XCellBattery_square1_4)
	.db CAL,<(XCellBattery_square1_5),>(XCellBattery_square1_5)
	.db CAL,<(XCellBattery_square1_6),>(XCellBattery_square1_6)
	.db CAL,<(XCellBattery_square1_7),>(XCellBattery_square1_7)
	.db CAL,<(XCellBattery_square1_8),>(XCellBattery_square1_8)
	.db CAL,<(XCellBattery_square1_9),>(XCellBattery_square1_9)
	.db CAL,<(XCellBattery_square1_10),>(XCellBattery_square1_10)
	.db CAL,<(XCellBattery_square1_11),>(XCellBattery_square1_11)
	.db CAL,<(XCellBattery_square1_12),>(XCellBattery_square1_12)
	.db CAL,<(XCellBattery_square1_13),>(XCellBattery_square1_13)
	.db CAL,<(XCellBattery_square1_8),>(XCellBattery_square1_8)
	.db CAL,<(XCellBattery_square1_9),>(XCellBattery_square1_9)
	.db CAL,<(XCellBattery_square1_10),>(XCellBattery_square1_10)
	.db CAL,<(XCellBattery_square1_11),>(XCellBattery_square1_11)
	.db CAL,<(XCellBattery_square1_12),>(XCellBattery_square1_12)
	.db CAL,<(XCellBattery_square1_13),>(XCellBattery_square1_13)
	.db CAL,<(XCellBattery_square1_14),>(XCellBattery_square1_14)
	.db CAL,<(XCellBattery_square1_15),>(XCellBattery_square1_15)
	.db CAL,<(XCellBattery_square1_16),>(XCellBattery_square1_16)
	.db CAL,<(XCellBattery_square1_17),>(XCellBattery_square1_17)
	.db CAL,<(XCellBattery_square1_18),>(XCellBattery_square1_18)
	.db CAL,<(XCellBattery_square1_19),>(XCellBattery_square1_19)
	.db CAL,<(XCellBattery_square1_18),>(XCellBattery_square1_18)
	.db CAL,<(XCellBattery_square1_19),>(XCellBattery_square1_19)
	.db CAL,<(XCellBattery_square1_20),>(XCellBattery_square1_20)
	.db CAL,<(XCellBattery_square1_21),>(XCellBattery_square1_21)
	.db CAL,<(XCellBattery_square1_20),>(XCellBattery_square1_20)
	.db CAL,<(XCellBattery_square1_21),>(XCellBattery_square1_21)
	.db CAL,<(XCellBattery_square1_22),>(XCellBattery_square1_22)
	.db CAL,<(XCellBattery_square1_23),>(XCellBattery_square1_23)
	.db CAL,<(XCellBattery_square1_24),>(XCellBattery_square1_24)
	.db CAL,<(XCellBattery_square1_25),>(XCellBattery_square1_25)
	.db CAL,<(XCellBattery_square1_8),>(XCellBattery_square1_8)
	.db CAL,<(XCellBattery_square1_9),>(XCellBattery_square1_9)
	.db CAL,<(XCellBattery_square1_10),>(XCellBattery_square1_10)
	.db CAL,<(XCellBattery_square1_11),>(XCellBattery_square1_11)
	.db CAL,<(XCellBattery_square1_12),>(XCellBattery_square1_12)
	.db CAL,<(XCellBattery_square1_13),>(XCellBattery_square1_13)
	.db CAL,<(XCellBattery_square1_8),>(XCellBattery_square1_8)
	.db CAL,<(XCellBattery_square1_9),>(XCellBattery_square1_9)
	.db CAL,<(XCellBattery_square1_10),>(XCellBattery_square1_10)
	.db CAL,<(XCellBattery_square1_11),>(XCellBattery_square1_11)
	.db CAL,<(XCellBattery_square1_12),>(XCellBattery_square1_12)
	.db CAL,<(XCellBattery_square1_13),>(XCellBattery_square1_13)
	.db CAL,<(XCellBattery_square1_26),>(XCellBattery_square1_26)
	.db CAL,<(XCellBattery_square1_27),>(XCellBattery_square1_27)
	.db CAL,<(XCellBattery_square1_28),>(XCellBattery_square1_28)
	.db CAL,<(XCellBattery_square1_29),>(XCellBattery_square1_29)
	.db CAL,<(XCellBattery_square1_30),>(XCellBattery_square1_30)
	.db CAL,<(XCellBattery_square1_31),>(XCellBattery_square1_31)
	.db CAL,<(XCellBattery_square1_32),>(XCellBattery_square1_32)
	.db CAL,<(XCellBattery_square1_33),>(XCellBattery_square1_33)
	.db CAL,<(XCellBattery_square1_34),>(XCellBattery_square1_34)
	.db CAL,<(XCellBattery_square1_35),>(XCellBattery_square1_35)
	.db CAL,<(XCellBattery_square1_36),>(XCellBattery_square1_36)
	.db CAL,<(XCellBattery_square1_36),>(XCellBattery_square1_36)
	.db CAL,<(XCellBattery_square1_37),>(XCellBattery_square1_37)
	.db CAL,<(XCellBattery_square1_38),>(XCellBattery_square1_38)
	.db CAL,<(XCellBattery_square1_39),>(XCellBattery_square1_39)
	.db CAL,<(XCellBattery_square1_40),>(XCellBattery_square1_40)
	.db CAL,<(XCellBattery_square1_41),>(XCellBattery_square1_41)
	.db CAL,<(XCellBattery_square1_42),>(XCellBattery_square1_42)
	.db CAL,<(XCellBattery_square1_43),>(XCellBattery_square1_43)
	.db CAL,<(XCellBattery_square1_44),>(XCellBattery_square1_44)
	.db CAL,<(XCellBattery_square1_45),>(XCellBattery_square1_45)
	.db CAL,<(XCellBattery_square1_46),>(XCellBattery_square1_46)
	.db CAL,<(XCellBattery_square1_47),>(XCellBattery_square1_47)
	.db CAL,<(XCellBattery_square1_48),>(XCellBattery_square1_48)
	.db GOT
	.dw XCellBattery_square1

XCellBattery_square2:
	.db CAL,<(XCellBattery_square2_0),>(XCellBattery_square2_0)
	.db CAL,<(XCellBattery_square2_1),>(XCellBattery_square2_1)
	.db CAL,<(XCellBattery_square2_2),>(XCellBattery_square2_2)
	.db CAL,<(XCellBattery_square2_3),>(XCellBattery_square2_3)
	.db CAL,<(XCellBattery_square2_0),>(XCellBattery_square2_0)
	.db CAL,<(XCellBattery_square2_1),>(XCellBattery_square2_1)
	.db CAL,<(XCellBattery_square2_2),>(XCellBattery_square2_2)
	.db CAL,<(XCellBattery_square2_3),>(XCellBattery_square2_3)
	.db CAL,<(XCellBattery_square2_4),>(XCellBattery_square2_4)
	.db CAL,<(XCellBattery_square2_5),>(XCellBattery_square2_5)
	.db CAL,<(XCellBattery_square2_6),>(XCellBattery_square2_6)
	.db CAL,<(XCellBattery_square2_7),>(XCellBattery_square2_7)
	.db CAL,<(XCellBattery_square2_8),>(XCellBattery_square2_8)
	.db CAL,<(XCellBattery_square2_9),>(XCellBattery_square2_9)
	.db CAL,<(XCellBattery_square2_10),>(XCellBattery_square2_10)
	.db CAL,<(XCellBattery_square2_11),>(XCellBattery_square2_11)
	.db CAL,<(XCellBattery_square2_12),>(XCellBattery_square2_12)
	.db CAL,<(XCellBattery_square2_13),>(XCellBattery_square2_13)
	.db CAL,<(XCellBattery_square2_8),>(XCellBattery_square2_8)
	.db CAL,<(XCellBattery_square2_9),>(XCellBattery_square2_9)
	.db CAL,<(XCellBattery_square2_10),>(XCellBattery_square2_10)
	.db CAL,<(XCellBattery_square2_11),>(XCellBattery_square2_11)
	.db CAL,<(XCellBattery_square2_12),>(XCellBattery_square2_12)
	.db CAL,<(XCellBattery_square2_13),>(XCellBattery_square2_13)
	.db CAL,<(XCellBattery_square2_14),>(XCellBattery_square2_14)
	.db CAL,<(XCellBattery_square2_14),>(XCellBattery_square2_14)
	.db CAL,<(XCellBattery_square2_14),>(XCellBattery_square2_14)
	.db CAL,<(XCellBattery_square2_14),>(XCellBattery_square2_14)
	.db CAL,<(XCellBattery_square2_14),>(XCellBattery_square2_14)
	.db CAL,<(XCellBattery_square2_15),>(XCellBattery_square2_15)
	.db CAL,<(XCellBattery_square2_16),>(XCellBattery_square2_16)
	.db CAL,<(XCellBattery_square2_17),>(XCellBattery_square2_17)
	.db CAL,<(XCellBattery_square2_18),>(XCellBattery_square2_18)
	.db CAL,<(XCellBattery_square2_19),>(XCellBattery_square2_19)
	.db CAL,<(XCellBattery_square2_18),>(XCellBattery_square2_18)
	.db CAL,<(XCellBattery_square2_19),>(XCellBattery_square2_19)
	.db CAL,<(XCellBattery_square2_20),>(XCellBattery_square2_20)
	.db CAL,<(XCellBattery_square2_21),>(XCellBattery_square2_21)
	.db CAL,<(XCellBattery_square2_14),>(XCellBattery_square2_14)
	.db CAL,<(XCellBattery_square2_14),>(XCellBattery_square2_14)
	.db CAL,<(XCellBattery_square2_8),>(XCellBattery_square2_8)
	.db CAL,<(XCellBattery_square2_9),>(XCellBattery_square2_9)
	.db CAL,<(XCellBattery_square2_10),>(XCellBattery_square2_10)
	.db CAL,<(XCellBattery_square2_11),>(XCellBattery_square2_11)
	.db CAL,<(XCellBattery_square2_12),>(XCellBattery_square2_12)
	.db CAL,<(XCellBattery_square2_13),>(XCellBattery_square2_13)
	.db CAL,<(XCellBattery_square2_22),>(XCellBattery_square2_22)
	.db CAL,<(XCellBattery_square2_23),>(XCellBattery_square2_23)
	.db CAL,<(XCellBattery_square2_22),>(XCellBattery_square2_22)
	.db CAL,<(XCellBattery_square2_24),>(XCellBattery_square2_24)
	.db CAL,<(XCellBattery_square2_25),>(XCellBattery_square2_25)
	.db CAL,<(XCellBattery_square2_26),>(XCellBattery_square2_26)
	.db CAL,<(XCellBattery_square2_14),>(XCellBattery_square2_14)
	.db CAL,<(XCellBattery_square2_14),>(XCellBattery_square2_14)
	.db CAL,<(XCellBattery_square2_14),>(XCellBattery_square2_14)
	.db CAL,<(XCellBattery_square2_14),>(XCellBattery_square2_14)
	.db CAL,<(XCellBattery_square2_14),>(XCellBattery_square2_14)
	.db CAL,<(XCellBattery_square2_14),>(XCellBattery_square2_14)
	.db CAL,<(XCellBattery_square2_14),>(XCellBattery_square2_14)
	.db CAL,<(XCellBattery_square2_14),>(XCellBattery_square2_14)
	.db CAL,<(XCellBattery_square2_14),>(XCellBattery_square2_14)
	.db CAL,<(XCellBattery_square2_14),>(XCellBattery_square2_14)
	.db CAL,<(XCellBattery_square2_14),>(XCellBattery_square2_14)
	.db CAL,<(XCellBattery_square2_14),>(XCellBattery_square2_14)
	.db CAL,<(XCellBattery_square2_14),>(XCellBattery_square2_14)
	.db CAL,<(XCellBattery_square2_14),>(XCellBattery_square2_14)
	.db CAL,<(XCellBattery_square2_14),>(XCellBattery_square2_14)
	.db CAL,<(XCellBattery_square2_14),>(XCellBattery_square2_14)
	.db CAL,<(XCellBattery_square2_14),>(XCellBattery_square2_14)
	.db CAL,<(XCellBattery_square2_14),>(XCellBattery_square2_14)
	.db CAL,<(XCellBattery_square2_14),>(XCellBattery_square2_14)
	.db CAL,<(XCellBattery_square2_14),>(XCellBattery_square2_14)
	.db CAL,<(XCellBattery_square2_14),>(XCellBattery_square2_14)
	.db CAL,<(XCellBattery_square2_14),>(XCellBattery_square2_14)
	.db CAL,<(XCellBattery_square2_14),>(XCellBattery_square2_14)
	.db CAL,<(XCellBattery_square2_27),>(XCellBattery_square2_27)
	.db GOT
	.dw XCellBattery_square2

XCellBattery_triangle:
	.db CAL,<(XCellBattery_triangle_0),>(XCellBattery_triangle_0)
	.db CAL,<(XCellBattery_triangle_1),>(XCellBattery_triangle_1)
	.db CAL,<(XCellBattery_triangle_0),>(XCellBattery_triangle_0)
	.db CAL,<(XCellBattery_triangle_1),>(XCellBattery_triangle_1)
	.db CAL,<(XCellBattery_triangle_0),>(XCellBattery_triangle_0)
	.db CAL,<(XCellBattery_triangle_1),>(XCellBattery_triangle_1)
	.db CAL,<(XCellBattery_triangle_0),>(XCellBattery_triangle_0)
	.db CAL,<(XCellBattery_triangle_1),>(XCellBattery_triangle_1)
	.db CAL,<(XCellBattery_triangle_0),>(XCellBattery_triangle_0)
	.db CAL,<(XCellBattery_triangle_1),>(XCellBattery_triangle_1)
	.db CAL,<(XCellBattery_triangle_0),>(XCellBattery_triangle_0)
	.db CAL,<(XCellBattery_triangle_1),>(XCellBattery_triangle_1)
	.db CAL,<(XCellBattery_triangle_0),>(XCellBattery_triangle_0)
	.db CAL,<(XCellBattery_triangle_1),>(XCellBattery_triangle_1)
	.db CAL,<(XCellBattery_triangle_0),>(XCellBattery_triangle_0)
	.db CAL,<(XCellBattery_triangle_1),>(XCellBattery_triangle_1)
	.db CAL,<(XCellBattery_triangle_0),>(XCellBattery_triangle_0)
	.db CAL,<(XCellBattery_triangle_1),>(XCellBattery_triangle_1)
	.db CAL,<(XCellBattery_triangle_0),>(XCellBattery_triangle_0)
	.db CAL,<(XCellBattery_triangle_1),>(XCellBattery_triangle_1)
	.db CAL,<(XCellBattery_triangle_0),>(XCellBattery_triangle_0)
	.db CAL,<(XCellBattery_triangle_1),>(XCellBattery_triangle_1)
	.db CAL,<(XCellBattery_triangle_0),>(XCellBattery_triangle_0)
	.db CAL,<(XCellBattery_triangle_1),>(XCellBattery_triangle_1)
	.db CAL,<(XCellBattery_triangle_2),>(XCellBattery_triangle_2)
	.db CAL,<(XCellBattery_triangle_3),>(XCellBattery_triangle_3)
	.db CAL,<(XCellBattery_triangle_4),>(XCellBattery_triangle_4)
	.db CAL,<(XCellBattery_triangle_5),>(XCellBattery_triangle_5)
	.db CAL,<(XCellBattery_triangle_0),>(XCellBattery_triangle_0)
	.db CAL,<(XCellBattery_triangle_1),>(XCellBattery_triangle_1)
	.db CAL,<(XCellBattery_triangle_0),>(XCellBattery_triangle_0)
	.db CAL,<(XCellBattery_triangle_1),>(XCellBattery_triangle_1)
	.db CAL,<(XCellBattery_triangle_0),>(XCellBattery_triangle_0)
	.db CAL,<(XCellBattery_triangle_1),>(XCellBattery_triangle_1)
	.db CAL,<(XCellBattery_triangle_0),>(XCellBattery_triangle_0)
	.db CAL,<(XCellBattery_triangle_1),>(XCellBattery_triangle_1)
	.db CAL,<(XCellBattery_triangle_0),>(XCellBattery_triangle_0)
	.db CAL,<(XCellBattery_triangle_1),>(XCellBattery_triangle_1)
	.db CAL,<(XCellBattery_triangle_0),>(XCellBattery_triangle_0)
	.db CAL,<(XCellBattery_triangle_1),>(XCellBattery_triangle_1)
	.db CAL,<(XCellBattery_triangle_0),>(XCellBattery_triangle_0)
	.db CAL,<(XCellBattery_triangle_1),>(XCellBattery_triangle_1)
	.db CAL,<(XCellBattery_triangle_0),>(XCellBattery_triangle_0)
	.db CAL,<(XCellBattery_triangle_1),>(XCellBattery_triangle_1)
	.db CAL,<(XCellBattery_triangle_0),>(XCellBattery_triangle_0)
	.db CAL,<(XCellBattery_triangle_1),>(XCellBattery_triangle_1)
	.db CAL,<(XCellBattery_triangle_0),>(XCellBattery_triangle_0)
	.db CAL,<(XCellBattery_triangle_1),>(XCellBattery_triangle_1)
	.db CAL,<(XCellBattery_triangle_1),>(XCellBattery_triangle_1)
	.db CAL,<(XCellBattery_triangle_1),>(XCellBattery_triangle_1)
	.db CAL,<(XCellBattery_triangle_0),>(XCellBattery_triangle_0)
	.db CAL,<(XCellBattery_triangle_1),>(XCellBattery_triangle_1)
	.db CAL,<(XCellBattery_triangle_6),>(XCellBattery_triangle_6)
	.db CAL,<(XCellBattery_triangle_7),>(XCellBattery_triangle_7)
	.db CAL,<(XCellBattery_triangle_8),>(XCellBattery_triangle_8)
	.db CAL,<(XCellBattery_triangle_9),>(XCellBattery_triangle_9)
	.db CAL,<(XCellBattery_triangle_10),>(XCellBattery_triangle_10)
	.db CAL,<(XCellBattery_triangle_11),>(XCellBattery_triangle_11)
	.db CAL,<(XCellBattery_triangle_12),>(XCellBattery_triangle_12)
	.db CAL,<(XCellBattery_triangle_13),>(XCellBattery_triangle_13)
	.db CAL,<(XCellBattery_triangle_14),>(XCellBattery_triangle_14)
	.db CAL,<(XCellBattery_triangle_15),>(XCellBattery_triangle_15)
	.db CAL,<(XCellBattery_triangle_16),>(XCellBattery_triangle_16)
	.db CAL,<(XCellBattery_triangle_17),>(XCellBattery_triangle_17)
	.db CAL,<(XCellBattery_triangle_18),>(XCellBattery_triangle_18)
	.db CAL,<(XCellBattery_triangle_19),>(XCellBattery_triangle_19)
	.db CAL,<(XCellBattery_triangle_20),>(XCellBattery_triangle_20)
	.db CAL,<(XCellBattery_triangle_21),>(XCellBattery_triangle_21)
	.db CAL,<(XCellBattery_triangle_22),>(XCellBattery_triangle_22)
	.db CAL,<(XCellBattery_triangle_23),>(XCellBattery_triangle_23)
	.db CAL,<(XCellBattery_triangle_24),>(XCellBattery_triangle_24)
	.db CAL,<(XCellBattery_triangle_25),>(XCellBattery_triangle_25)
	.db CAL,<(XCellBattery_triangle_26),>(XCellBattery_triangle_26)
	.db CAL,<(XCellBattery_triangle_27),>(XCellBattery_triangle_27)
	.db CAL,<(XCellBattery_triangle_28),>(XCellBattery_triangle_28)
	.db CAL,<(XCellBattery_triangle_29),>(XCellBattery_triangle_29)
	.db GOT
	.dw XCellBattery_triangle

XCellBattery_noise:
	.db CAL,<(XCellBattery_noise_0),>(XCellBattery_noise_0)
	.db CAL,<(XCellBattery_noise_0),>(XCellBattery_noise_0)
	.db CAL,<(XCellBattery_noise_0),>(XCellBattery_noise_0)
	.db CAL,<(XCellBattery_noise_0),>(XCellBattery_noise_0)
	.db CAL,<(XCellBattery_noise_0),>(XCellBattery_noise_0)
	.db CAL,<(XCellBattery_noise_0),>(XCellBattery_noise_0)
	.db CAL,<(XCellBattery_noise_0),>(XCellBattery_noise_0)
	.db CAL,<(XCellBattery_noise_1),>(XCellBattery_noise_1)
	.db CAL,<(XCellBattery_noise_2),>(XCellBattery_noise_2)
	.db CAL,<(XCellBattery_noise_2),>(XCellBattery_noise_2)
	.db CAL,<(XCellBattery_noise_2),>(XCellBattery_noise_2)
	.db CAL,<(XCellBattery_noise_2),>(XCellBattery_noise_2)
	.db CAL,<(XCellBattery_noise_2),>(XCellBattery_noise_2)
	.db CAL,<(XCellBattery_noise_2),>(XCellBattery_noise_2)
	.db CAL,<(XCellBattery_noise_2),>(XCellBattery_noise_2)
	.db CAL,<(XCellBattery_noise_2),>(XCellBattery_noise_2)
	.db CAL,<(XCellBattery_noise_2),>(XCellBattery_noise_2)
	.db CAL,<(XCellBattery_noise_2),>(XCellBattery_noise_2)
	.db CAL,<(XCellBattery_noise_2),>(XCellBattery_noise_2)
	.db CAL,<(XCellBattery_noise_2),>(XCellBattery_noise_2)
	.db CAL,<(XCellBattery_noise_2),>(XCellBattery_noise_2)
	.db CAL,<(XCellBattery_noise_2),>(XCellBattery_noise_2)
	.db CAL,<(XCellBattery_noise_2),>(XCellBattery_noise_2)
	.db CAL,<(XCellBattery_noise_2),>(XCellBattery_noise_2)
	.db CAL,<(XCellBattery_noise_1),>(XCellBattery_noise_1)
	.db CAL,<(XCellBattery_noise_1),>(XCellBattery_noise_1)
	.db CAL,<(XCellBattery_noise_1),>(XCellBattery_noise_1)
	.db CAL,<(XCellBattery_noise_1),>(XCellBattery_noise_1)
	.db CAL,<(XCellBattery_noise_0),>(XCellBattery_noise_0)
	.db CAL,<(XCellBattery_noise_0),>(XCellBattery_noise_0)
	.db CAL,<(XCellBattery_noise_0),>(XCellBattery_noise_0)
	.db CAL,<(XCellBattery_noise_0),>(XCellBattery_noise_0)
	.db CAL,<(XCellBattery_noise_0),>(XCellBattery_noise_0)
	.db CAL,<(XCellBattery_noise_0),>(XCellBattery_noise_0)
	.db CAL,<(XCellBattery_noise_0),>(XCellBattery_noise_0)
	.db CAL,<(XCellBattery_noise_0),>(XCellBattery_noise_0)
	.db CAL,<(XCellBattery_noise_0),>(XCellBattery_noise_0)
	.db CAL,<(XCellBattery_noise_0),>(XCellBattery_noise_0)
	.db CAL,<(XCellBattery_noise_0),>(XCellBattery_noise_0)
	.db CAL,<(XCellBattery_noise_0),>(XCellBattery_noise_0)
	.db CAL,<(XCellBattery_noise_2),>(XCellBattery_noise_2)
	.db CAL,<(XCellBattery_noise_2),>(XCellBattery_noise_2)
	.db CAL,<(XCellBattery_noise_2),>(XCellBattery_noise_2)
	.db CAL,<(XCellBattery_noise_2),>(XCellBattery_noise_2)
	.db CAL,<(XCellBattery_noise_2),>(XCellBattery_noise_2)
	.db CAL,<(XCellBattery_noise_2),>(XCellBattery_noise_2)
	.db CAL,<(XCellBattery_noise_2),>(XCellBattery_noise_2)
	.db CAL,<(XCellBattery_noise_2),>(XCellBattery_noise_2)
	.db CAL,<(XCellBattery_noise_2),>(XCellBattery_noise_2)
	.db CAL,<(XCellBattery_noise_2),>(XCellBattery_noise_2)
	.db CAL,<(XCellBattery_noise_2),>(XCellBattery_noise_2)
	.db CAL,<(XCellBattery_noise_2),>(XCellBattery_noise_2)
	.db CAL,<(XCellBattery_noise_0),>(XCellBattery_noise_0)
	.db CAL,<(XCellBattery_noise_0),>(XCellBattery_noise_0)
	.db CAL,<(XCellBattery_noise_0),>(XCellBattery_noise_0)
	.db CAL,<(XCellBattery_noise_0),>(XCellBattery_noise_0)
	.db CAL,<(XCellBattery_noise_0),>(XCellBattery_noise_0)
	.db CAL,<(XCellBattery_noise_0),>(XCellBattery_noise_0)
	.db CAL,<(XCellBattery_noise_0),>(XCellBattery_noise_0)
	.db CAL,<(XCellBattery_noise_1),>(XCellBattery_noise_1)
	.db CAL,<(XCellBattery_noise_1),>(XCellBattery_noise_1)
	.db CAL,<(XCellBattery_noise_1),>(XCellBattery_noise_1)
	.db CAL,<(XCellBattery_noise_0),>(XCellBattery_noise_0)
	.db CAL,<(XCellBattery_noise_0),>(XCellBattery_noise_0)
	.db CAL,<(XCellBattery_noise_3),>(XCellBattery_noise_3)
	.db CAL,<(XCellBattery_noise_4),>(XCellBattery_noise_4)
	.db CAL,<(XCellBattery_noise_2),>(XCellBattery_noise_2)
	.db CAL,<(XCellBattery_noise_2),>(XCellBattery_noise_2)
	.db CAL,<(XCellBattery_noise_2),>(XCellBattery_noise_2)
	.db CAL,<(XCellBattery_noise_2),>(XCellBattery_noise_2)
	.db CAL,<(XCellBattery_noise_2),>(XCellBattery_noise_2)
	.db CAL,<(XCellBattery_noise_2),>(XCellBattery_noise_2)
	.db CAL,<(XCellBattery_noise_2),>(XCellBattery_noise_2)
	.db CAL,<(XCellBattery_noise_2),>(XCellBattery_noise_2)
	.db CAL,<(XCellBattery_noise_2),>(XCellBattery_noise_2)
	.db CAL,<(XCellBattery_noise_5),>(XCellBattery_noise_5)
	.db GOT
	.dw XCellBattery_noise


XCellBattery_square1_0:
	.db STI,0,SL6,B3,STI,4,SLL,30,A0,STI,0,SL6,AS3,STI,4,SLL,42,A0,STI,0
	.db SL6,B3,STI,4,A0
	.db RET


XCellBattery_square2_0:
	.db STI,0,SL3,GS3,STI,4,SLL,33,A0,STI,0,SL3,G3,STI,4,SLL,45,A0,STI,0
	.db SL3,GS3,STI,4,SL9,A0
	.db RET


XCellBattery_triangle_0:
	.db STI,0,SL6,GS1,SL3,GS2,STI,4,A0,STI,0,GS2,STI,4,A0,STI,0,GS2,STI,4
	.db A0,STI,0,SL6,GS1,SL3,GS2,STI,4,A0,STI,0,GS2,STI,4,A0,STI,0,GS2
	.db STI,4,A0,STI,0,SL6,GS1,SL3,GS2,STI,4,A0,STI,0,GS2,STI,4,A0,STI,0
	.db GS2,STI,4,A0,STI,0,SL6,GS1,SL3,GS2,STI,4,A0,STI,0,GS2,STI,4,A0
	.db STI,0,GS2,STI,4,A0
	.db RET


XCellBattery_noise_0:
	.db STI,0,SL3,#$0,STI,4,SLL,21,0,STI,0,SL3,#$0,STI,4,SLL,21,0,STI,0
	.db SL3,#$0,STI,4,SLL,21,0,STI,0,SL3,#$0,STI,4,SLL,21,0
	.db RET


XCellBattery_square1_1:
	.db STI,4,SLC,A0,STI,0,SL6,AS3,STI,4,SLL,18,A0,STI,0,SL6,AS3,STI,4
	.db SLL,18,A0,STI,0,SL6,B3,STI,4,A0,STI,0,GS3,STI,4,SLL,18,A0
	.db RET


XCellBattery_square2_1:
	.db STI,4,SLC,A0,STI,0,SL3,G3,STI,4,SLL,21,A0,STI,0,SL3,G3,STI,4
	.db SLL,21,A0,STI,0,SL3,GS3,STI,4,SL9,A0,STI,0,SL3,DS3,STI,4,SLL,21
	.db A0
	.db RET


XCellBattery_triangle_1:
	.db STI,0,SL6,GS1,SL3,GS2,STI,4,A0,STI,0,GS2,STI,4,A0,STI,0,GS2,STI,4
	.db A0,STI,0,SL6,GS1,SL3,B2,STI,4,A0,STI,0,B2,STI,4,A0,STI,0,B2,STI,4
	.db A0,STI,0,SL6,GS1,SL3,AS2,STI,4,A0,STI,0,AS2,STI,4,A0,STI,0,AS2
	.db STI,4,A0,STI,0,SL6,GS1,SL3,A2,STI,4,A0,STI,0,A2,STI,4,A0,STI,0
	.db A2,STI,4,A0
	.db RET


XCellBattery_square1_2:
	.db STI,0,SL6,DS4,STI,4,SLL,30,A0,STI,0,SL6,CS4,STI,4,SLL,18,A0,STI,0
	.db SL6,DS4,STI,4,A0,STI,0,CS4,STI,4,SLL,18,A0
	.db RET


XCellBattery_square2_2:
	.db STI,0,SL3,B3,STI,4,SLL,33,A0,STI,0,SL3,AS3,STI,4,SLL,21,A0,STI,0
	.db SL3,B3,STI,4,SL9,A0,STI,0,SL3,GS3,STI,4,SLL,21,A0
	.db RET


XCellBattery_square1_3:
	.db STI,0,SL6,B3,STI,4,A0,STI,0,B3,STI,4,A0,STI,0,GS3,STI,4,SLL,30
	.db A0,STI,0,SL6,DS3,STI,4,SLC,A0,STI,0,SL6,G3,STI,4,SLC,A0
	.db RET


XCellBattery_square2_3:
	.db STI,0,SL3,DS3,STI,4,SL9,A0,STI,0,SL3,DS3,STI,4,SL9,A0,STI,0,SL3
	.db GS2,STI,4,SLL,33,A0,STI,0,SL3,DS2,STI,4,SLF,A0,STI,0,SL3,G2,STI,4
	.db SLF,A0
	.db RET


XCellBattery_noise_1:
	.db STI,4,SLL,96,0
	.db RET


XCellBattery_square1_4:
	.db STI,0,SL6,GS3,STI,4,SLL,30,A0,STI,0,SL6,B3,STI,4,SLL,30,A0,STI,0
	.db SL6,GS3,STI,4,SLL,18,A0
	.db RET


XCellBattery_square2_4:
	.db STI,0,SL6,GS2,STI,4,SLL,30,A0,STI,0,SL6,DS2,STI,4,SLL,30,A0,STI,0
	.db SL6,AS2,STI,4,SLL,18,A0
	.db RET


XCellBattery_noise_2:
	.db STI,0,SL3,#$0,STI,4,SL9,0,STI,0,SL3,#$0,STI,4,0,STI,1,#$5,STI,4
	.db SLF,0,STI,1,SL3,#$5,STI,4,SLF,0,STI,1,SL3,#$5,STI,4,SL9,0,STI,0
	.db SL3,#$0,STI,4,0,STI,1,#$5,STI,4,SLL,21,0
	.db RET


XCellBattery_square1_5:
	.db STI,0,SL6,DS4,STI,4,A0,STI,0,D4,STI,4,SLL,36,A0,STI,0,SL6,CS4
	.db STI,4,SLC,A0,STI,0,SL6,CS4,STI,4,A0,STI,0,B3,STI,4,A0
	.db RET


XCellBattery_square2_5:
	.db STI,0,SL6,B2,STI,4,A0,STI,0,AS2,STI,4,SLL,36,A0,STI,0,SL6,GS2
	.db STI,4,SLC,A0,STI,0,SL6,GS2,STI,4,A0,STI,0,G2,STI,4,A0
	.db RET


XCellBattery_square1_6:
	.db STI,0,SL6,DS4,STI,4,SLC,A0,STI,0,SL6,GS3,STI,4,SLC,A0,STI,0,SL6
	.db FS3,STI,4,SLC,A0,STI,0,SL6,G3,STI,4,SLC,A0,STI,0,SL6,CS4,STI,4
	.db A0,STI,0,B3,STI,4,A0
	.db RET


XCellBattery_square2_6:
	.db STI,0,SL6,B2,STI,4,SLC,A0,STI,0,SL6,GS2,STI,4,SLC,A0,STI,0,SL6
	.db FS2,STI,4,SLC,A0,STI,0,SL6,G2,STI,4,SLC,A0,STI,0,SL6,AS2,STI,4
	.db A0,STI,0,GS2,STI,4,A0
	.db RET


XCellBattery_square1_7:
	.db STI,4,SL6,A0,STI,0,G3,GS3,AS3,B3,AS3,B3,CS4,DS4,STI,4,A0,STI,0
	.db DS4,STI,4,A0,STI,0,DS4,E4,SLC,DS4
	.db RET


XCellBattery_square2_7:
	.db STI,4,SL6,A0,STI,0,DS2,F2,G2,GS2,G2,GS2,AS2,B2,STI,4,A0,STI,0
	.db B2,STI,4,A0,STI,0,B2,CS3,B2,STI,4,A0
	.db RET


XCellBattery_square1_8:
	.db STI,0,SLC,B3,STI,4,SL6,A0,STI,0,SLC,GS3,STI,4,SLL,30,A0,STI,0
	.db SL6,GS3,STI,4,A0,STI,0,B3,STI,4,A0,STI,0,GS3,STI,4,A0
	.db RET


XCellBattery_square2_8:
	.db STI,0,SL6,GS2,STI,4,SLC,A0,STI,0,SL6,B2,STI,4,SLC,A0,STI,0,SL6
	.db GS2,STI,4,SLL,18,A0,STI,0,SL6,DS3,STI,4,A0,STI,0,CS3,B2,STI,4
	.db A0,STI,0,FS2
	.db RET


XCellBattery_square1_9:
	.db STI,0,SLC,CS4,STI,4,A0,STI,0,DS4,STI,4,A0,STI,0,SL5,B3,STI,4
	.db SL1,A0,STI,0,SL4,AS3,STI,4,SL2,A0,STI,0,SLC,GS3,STI,4,A0,STI,0
	.db SL6,FS3,STI,4,A0
	.db RET


XCellBattery_square2_9:
	.db STI,0,SL6,GS2,STI,4,SLC,A0,STI,0,SL6,DS2,STI,4,SLC,A0,STI,0,SL6
	.db FS2,STI,4,A0,STI,0,GS2,STI,4,A0,STI,0,DS2,STI,4,A0,STI,0,CS2
	.db STI,4,A0,STI,0,B1,STI,4,A0
	.db RET


XCellBattery_square1_10:
	.db STI,0,SL6,GS3,STI,4,A0,STI,0,DS3,STI,4,SLC,A0,STI,0,SL6,FS3,STI,4
	.db SLC,A0,STI,0,SL6,GS3,STI,4,A0,STI,0,DS3,STI,4,A0,STI,0,CS3,STI,4
	.db A0,STI,0,B2,STI,4,A0
	.db RET


XCellBattery_square2_10:
	.db STI,0,SL6,GS1,STI,4,SLL,30,A0,STI,0,SL6,B1,STI,4,SLL,18,A0,STI,0
	.db SL6,CS2,STI,4,SLL,18,A0,STI,0,SL6,B1,STI,4,A0
	.db RET


XCellBattery_square1_11:
	.db STI,0,SL6,GS2,STI,4,SLL,30,A0,STI,0,SL6,B2,STI,4,SLL,18,A0,STI,0
	.db SL6,CS3,STI,4,SLC,A0,STI,0,SL6,B2,STI,4,SLC,A0
	.db RET


XCellBattery_square2_11:
	.db STI,0,SL6,DS2,STI,4,A0,STI,0,GS1,STI,4,SLL,18,A0,STI,0,SL6,GS2
	.db STI,4,SLL,18,A0,STI,0,SL6,CS2,STI,4,SLC,A0,STI,0,SL6,B1,STI,4
	.db SLC,A0
	.db RET


XCellBattery_square1_12:
	.db STI,0,SL6,DS3,STI,4,SLC,A0,STI,0,SL6,GS2,STI,4,SLL,36,A0,STI,0
	.db SL6,DS3,STI,4,A0,STI,0,CS3,STI,4,A0,STI,0,B2,STI,4,A0
	.db RET


XCellBattery_square2_12:
	.db STI,0,SL6,DS2,STI,4,SLC,A0,STI,0,SL6,GS1,STI,4,SLL,24,A0,STI,0
	.db SL6,B2,GS2,FS2,F2,E2,DS2,E2,F2
	.db RET


XCellBattery_square1_13:
	.db STI,4,SLC,A0,STI,0,SL6,B3,STI,4,SLC,A0,STI,0,SL6,GS3,STI,4,SLC
	.db A0,STI,0,SL6,FS3,STI,4,SLC,A0,STI,0,SL6,F3,STI,4,SLC,A0,STI,0
	.db SL6,E3,STI,4,A0
	.db RET


XCellBattery_square2_13:
	.db STI,0,SL6,GS2,STI,4,A0,STI,0,GS1,STI,4,SLC,A0,STI,0,SL6,DS2,STI,4
	.db SLC,A0,STI,0,SL6,CS2,STI,4,SLC,A0,STI,0,SL6,B1,STI,4,SLC,A0,STI,0
	.db SL6,AS1,STI,4,A0
	.db RET


XCellBattery_square1_14:
	.db STI,0,SLL,36,GS3,SLL,60,DS3
	.db RET


XCellBattery_square2_14:
	.db STI,4,SLL,96,A0
	.db RET


XCellBattery_triangle_2:
	.db STI,0,SL6,GS2,STI,4,A0,STI,0,GS2,STI,4,SLC,A0,STI,0,SL6,GS2,STI,4
	.db SLC,A0,STI,0,SL6,GS2,STI,4,A0,STI,0,GS2,STI,4,SLC,A0,STI,0,SL6
	.db GS2,STI,4,SLC,A0
	.db RET


XCellBattery_square1_15:
	.db STI,4,SL6,A0,A0,STI,0,GS2,STI,4,SLL,18,A0,STI,0,SL6,GS2,STI,4
	.db SLL,18,A0,STI,0,SL6,GS2,STI,4,A0,STI,0,GS2,STI,4,SLL,18,A0
	.db RET


XCellBattery_triangle_3:
	.db STI,0,SL6,B2,STI,4,A0,STI,0,B2,STI,4,SLC,A0,STI,0,SL6,AS2,STI,4
	.db SLC,A0,STI,0,SL6,AS2,STI,4,A0,STI,0,A2,STI,4,SLC,A0,STI,0,SL6
	.db GS2,DS2,STI,4,A0
	.db RET


XCellBattery_square1_16:
	.db STI,0,SL6,GS2,STI,4,A0,STI,0,GS2,STI,4,A0,STI,0,GS1,STI,4,A0
	.db STI,0,GS1,STI,4,A0,STI,0,GS2,STI,4,A0,STI,0,GS2,STI,4,A0,STI,0
	.db GS1,STI,4,A0,STI,0,GS1,STI,4,A0
	.db RET


XCellBattery_triangle_4:
	.db STI,0,SL6,GS2,STI,4,A0,STI,0,GS2,STI,4,SLC,A0,STI,0,SL6,GS2,STI,4
	.db SLC,A0,STI,0,SL6,GS2,STI,4,A0,STI,0,GS2,STI,4,SLC,A0,STI,0,SL6
	.db GS2,STI,4,SLC,A0
	.db RET


XCellBattery_square1_17:
	.db STI,4,SLC,A0,STI,0,SL6,DS2,E2,DS2,D2,DS2,CS2,B1,AS1,GS1,GS1,B1
	.db DS2,GS2,STI,4,A0
	.db RET


XCellBattery_triangle_5:
	.db STI,0,SL6,B2,STI,4,A0,STI,0,B2,STI,4,SLC,A0,STI,0,SL6,AS2,STI,4
	.db SLC,A0,STI,0,SL6,AS2,STI,4,A0,STI,0,A2,STI,4,SLC,A0,STI,0,SL6
	.db GS2,DS2,STI,4,A0
	.db RET


XCellBattery_square1_18:
	.db STI,4,SLC,A0,STI,0,SL6,GS2,STI,4,A0,STI,0,DS2,STI,4,A0,STI,0
	.db AS2,STI,4,A0,STI,0,B2,STI,4,SLC,A0,STI,0,SL6,FS2,STI,4,SLC,A0
	.db STI,0,SL6,F2,STI,4,A0
	.db RET


XCellBattery_square1_19:
	.db STI,4,SLC,A0,STI,0,SL6,GS1,STI,4,SLC,A0,STI,0,SL6,AS1,STI,4,SLC
	.db A0,STI,0,SL6,B1,STI,4,SLC,A0,STI,0,SL6,DS2,STI,4,SLC,A0,STI,0
	.db SL6,GS3,STI,4,A0
	.db RET


XCellBattery_square2_15:
	.db STI,4,SLC,A0,STI,0,SL6,DS4,STI,4,SLC,A0,STI,0,SL6,CS4,STI,4,SLC
	.db A0,STI,0,SL6,B3,STI,4,SLC,A0,STI,0,SL6,GS3,STI,4,SLC,A0,STI,0
	.db SL6,GS2,STI,4,A0
	.db RET


XCellBattery_square2_16:
	.db STI,4,SLC,A0,STI,0,SL6,DS4,STI,4,A0,STI,0,GS3,STI,4,A0,STI,0
	.db DS4,STI,4,A0,STI,0,FS4,STI,4,SLC,A0,STI,0,SL6,AS4,STI,4,SLC,A0
	.db STI,0,SL6,A4,STI,4,A0
	.db RET


XCellBattery_square2_17:
	.db STI,4,SLC,A0,STI,0,SL6,DS4,STI,4,SLC,A0,STI,0,SL6,CS4,STI,4,SLC
	.db A0,STI,0,SL6,B3,STI,4,SLC,A0,STI,0,SL6,GS3,STI,4,SLC,A0,STI,0
	.db SL6,GS4,STI,4,A0
	.db RET


XCellBattery_square1_20:
	.db STI,0,SL6,GS2,STI,4,SLC,A0,STI,0,SL6,GS1,STI,4,SLL,30,A0,STI,0
	.db SL6,B1,STI,4,SLC,A0,STI,0,SL6,B1,STI,4,SLL,18,A0
	.db RET


XCellBattery_square2_18:
	.db STI,3,SL6,GS4,STI,4,SLC,A0,STI,3,SL6,GS3,STI,4,SLL,30,A0,STI,3
	.db SL6,B3,STI,4,SLC,A0,STI,3,SL6,B3,STI,4,SLL,18,A0
	.db RET


XCellBattery_square1_21:
	.db STI,0,SL6,GS2,STI,4,SLC,A0,STI,0,SL6,GS1,STI,4,A0,STI,0,B1,STI,4
	.db A0,STI,0,AS1,STI,4,SLC,A0,STI,0,SL6,A1,STI,4,SLC,A0,STI,0,SL6
	.db GS1,STI,4,SLC,A0
	.db RET


XCellBattery_square2_19:
	.db STI,3,SL6,GS4,STI,4,SLC,A0,STI,3,SL6,GS3,STI,4,A0,STI,3,B3,STI,4
	.db A0,STI,3,AS3,STI,4,SLC,A0,STI,3,SL6,A3,STI,4,SLC,A0,STI,3,SL6
	.db GS3,STI,4,SLC,A0
	.db RET


XCellBattery_square1_22:
	.db STI,0,SLL,24,GS1,STI,4,SLC,A0,STI,0,SL6,GS1,STI,4,SLL,18,A0,STI,0
	.db SL6,GS1,STI,4,SLL,18,A0,STI,0,SL6,GS1,STI,4,A0
	.db RET


XCellBattery_square2_20:
	.db STI,0,SL6,GS2,STI,4,SLL,30,A0,STI,0,SL6,GS3,STI,4,SLL,18,A0,STI,0
	.db SL6,AS3,STI,4,SLL,18,A0,STI,0,SL6,GS3,STI,4,A0
	.db RET


XCellBattery_square1_23:
	.db STI,4,SLC,A0,STI,0,SL6,DS3,STI,4,SLC,A0,STI,0,SL6,CS3,STI,4,SLC
	.db A0,STI,0,SL6,B2,STI,4,SLC,A0,STI,0,SL6,GS2,STI,4,SLC,A0,STI,0
	.db SL6,FS2,STI,4,A0
	.db RET


XCellBattery_square2_21:
	.db STI,0,SLC,B3,STI,4,SLL,84,A0
	.db RET


XCellBattery_square1_24:
	.db STI,0,SLL,24,GS2,STI,4,SLC,A0,STI,0,SLL,24,GS1,STI,4,SLL,18,A0
	.db STI,0,SL6,DS2,F2,G2
	.db RET


XCellBattery_square1_25:
	.db STI,0,SL6,GS2,STI,4,A0,STI,0,G2,GS2,AS2,STI,4,A0,STI,0,AS2,B2
	.db CS3,GS3,B3,DS4,AS4,GS4,FS4,DS4
	.db RET


XCellBattery_square2_22:
	.db STI,0,SL6,GS1,GS2,DS2,GS2,STI,4,A0,STI,0,GS2,DS2,GS2,GS1,GS2
	.db DS2,GS2,STI,4,A0,STI,0,GS2,DS2,STI,4,A0
	.db RET


XCellBattery_square2_23:
	.db STI,0,SL6,GS1,GS2,DS2,GS2,STI,4,A0,STI,0,GS2,DS2,GS2,STI,4,A0
	.db STI,0,G2,GS2,AS2,B2,AS2,GS2,G2
	.db RET


XCellBattery_square2_24:
	.db STI,0,SL6,GS1,GS2,DS2,GS2,STI,4,A0,STI,0,GS2,DS2,GS2,B1,STI,4
	.db A0,STI,0,B1,STI,4,A0,STI,0,B1,CS2,B1,STI,4,A0
	.db RET


XCellBattery_square2_25:
	.db STI,3,SL6,GS1,STI,4,SLC,A0,STI,3,SL6,DS1,STI,4,SLL,30,A0,STI,3
	.db SL6,FS1,STI,4,SLC,A0,STI,1,SL6,FS1,GS1,FS1,STI,4,A0
	.db RET


XCellBattery_square2_26:
	.db STI,4,SLC,A0,STI,1,SL6,GS1,STI,4,SLC,A0,STI,1,SL6,FS1,STI,4,SLC
	.db A0,STI,1,SL6,F1,STI,4,SLC,A0,STI,1,SL6,E1,STI,4,SLC,A0,STI,1
	.db SL6,DS1,STI,4,A0
	.db RET


XCellBattery_square1_26:
	.db STI,0,SL6,GS2,SL5,GS1,STI,4,SL1,A0,STI,0,SL4,GS1,STI,4,SL2,A0
	.db STI,0,SL4,GS1,STI,4,SL2,A0,STI,0,SL5,GS1,STI,4,SL1,A0,STI,0,SL5
	.db GS1,STI,4,SL1,A0,STI,0,SL5,GS1,STI,4,SL1,A0,STI,0,SL4,GS1,STI,4
	.db SL8,A0,STI,0,SL5,GS1,STI,4,SL1,A0,STI,0,SL4,GS1,STI,4,SL2,A0
	.db STI,0,SL5,GS1,STI,4,SL1,A0,STI,0,SL4,GS1,STI,4,SL2,A0,STI,0,SL3
	.db GS1,STI,4,A0,STI,0,SL4,GS1,STI,4,SL8,A0
	.db RET


XCellBattery_triangle_6:
	.db STI,4,SL6,A0,STI,0,SL3,GS2,STI,4,A0,STI,0,GS2,STI,4,A0,STI,0
	.db GS2,STI,4,SL9,A0,STI,0,SL3,GS2,STI,4,A0,STI,0,GS2,STI,4,A0,STI,0
	.db GS2,STI,4,SL9,A0,STI,0,SL3,GS2,STI,4,A0,STI,0,GS2,STI,4,A0,STI,0
	.db GS2,STI,4,SL9,A0,STI,0,SL3,GS2,STI,4,A0,STI,0,GS2,STI,4,A0,STI,0
	.db GS2,STI,4,A0
	.db RET


XCellBattery_square1_27:
	.db STI,4,SL6,A0,STI,0,SL3,B2,STI,4,A0,STI,0,B2,STI,4,A0,STI,0,B2
	.db STI,4,A0,STI,0,AS2,STI,4,A0,STI,0,AS2,STI,4,SL9,A0,STI,0,SL3
	.db A2,STI,4,SL9,A0,STI,0,SL3,GS2,STI,4,A0,STI,0,GS2,STI,4,A0,STI,0
	.db GS2,STI,4,SLL,21,A0,STI,0,SL3,DS2,STI,4,A0
	.db RET


XCellBattery_triangle_7:
	.db STI,4,SL6,A0,STI,0,SL3,B2,STI,4,A0,STI,0,B2,STI,4,A0,STI,0,B2
	.db STI,4,A0,STI,0,AS2,STI,4,A0,STI,0,AS2,STI,4,SL9,A0,STI,0,SL3
	.db A2,STI,4,SL9,A0,STI,0,SL3,GS2,STI,4,A0,STI,0,GS2,STI,4,A0,STI,0
	.db GS2,STI,4,SLL,21,A0,STI,0,SL3,DS2,STI,4,A0
	.db RET


XCellBattery_square1_28:
	.db STI,4,SL6,A0,STI,0,SL3,DS2,STI,4,A0,STI,0,G2,STI,4,A0,STI,0,GS2
	.db STI,4,SL9,A0,STI,0,SL3,GS2,STI,4,A0,STI,0,B2,STI,4,A0,STI,0,D3
	.db STI,4,SL9,A0,STI,0,SL3,D3,STI,4,A0,STI,0,F3,STI,4,A0,STI,0,GS3
	.db STI,4,SL9,A0,STI,0,SL3,E3,STI,4,A0,STI,0,F3,STI,4,A0,STI,0,FS3
	.db STI,4,A0
	.db RET


XCellBattery_triangle_8:
	.db STI,4,SL6,A0,STI,0,SL3,DS2,STI,4,A0,STI,0,G2,STI,4,A0,STI,0,GS2
	.db STI,4,SL9,A0,STI,0,SL3,GS2,STI,4,A0,STI,0,B2,STI,4,A0,STI,0,D3
	.db STI,4,SL9,A0,STI,0,SL3,D3,STI,4,A0,STI,0,F3,STI,4,A0,STI,0,GS3
	.db STI,4,SL9,A0,STI,0,SL3,E3,STI,4,A0,STI,0,F3,STI,4,A0,STI,0,FS3
	.db STI,4,A0
	.db RET


XCellBattery_square1_29:
	.db STI,0,SL3,G3,STI,4,A0,STI,0,GS3,STI,4,A0,STI,0,GS3,STI,4,A0,STI,0
	.db GS3,STI,4,SL9,A0,STI,0,SL3,GS3,STI,4,A0,STI,0,GS3,STI,4,A0,STI,0
	.db GS3,STI,4,A0,STI,0,GS3,STI,4,A0,STI,0,GS3,STI,4,A0,STI,0,GS3
	.db STI,4,A0,STI,0,GS3,STI,4,A0,STI,0,GS3,STI,4,A0,STI,0,DS3,STI,4
	.db A0,STI,0,DS3,STI,4,A0,STI,0,DS3,STI,4,A0
	.db RET


XCellBattery_triangle_9:
	.db STI,0,SL3,G3,STI,4,A0,STI,0,GS3,STI,4,A0,STI,0,GS3,STI,4,A0,STI,0
	.db GS3,STI,4,SL9,A0,STI,0,SL3,GS3,STI,4,A0,STI,0,GS3,STI,4,A0,STI,0
	.db GS3,STI,4,A0,STI,0,GS3,STI,4,A0,STI,0,GS3,STI,4,A0,STI,0,GS3
	.db STI,4,A0,STI,0,GS3,STI,4,A0,STI,0,GS3,STI,4,A0,STI,0,DS3,STI,4
	.db A0,STI,0,DS3,STI,4,A0,STI,0,DS3,STI,4,A0
	.db RET


XCellBattery_square1_30:
	.db STI,4,SL6,A0,STI,0,SL3,GS2,STI,4,A0,STI,0,GS2,STI,4,A0,STI,0
	.db GS2,STI,4,SL9,A0,STI,0,SL3,GS2,STI,4,A0,STI,0,GS2,STI,4,A0,STI,0
	.db GS2,STI,4,SL9,A0,STI,0,SL3,B2,STI,4,A0,STI,0,B2,STI,4,A0,STI,0
	.db B2,STI,4,SL9,A0,STI,0,SL3,D3,STI,4,A0,STI,0,F3,STI,4,A0,STI,0
	.db GS3,STI,4,A0
	.db RET


XCellBattery_triangle_10:
	.db STI,4,SL6,A0,STI,0,SL3,GS2,STI,4,A0,STI,0,GS2,STI,4,A0,STI,0
	.db GS2,STI,4,SL9,A0,STI,0,SL3,GS2,STI,4,A0,STI,0,GS2,STI,4,A0,STI,0
	.db GS2,STI,4,SL9,A0,STI,0,SL3,B2,STI,4,A0,STI,0,B2,STI,4,A0,STI,0
	.db B2,STI,4,SL9,A0,STI,0,SL3,D3,STI,4,A0,STI,0,F3,STI,4,A0,STI,0
	.db GS3,STI,4,A0
	.db RET


XCellBattery_square1_31:
	.db STI,4,SL6,A0,STI,0,SL3,B2,STI,4,A0,STI,0,B2,STI,4,A0,STI,0,B2
	.db STI,4,SL9,A0,STI,0,SL3,B2,STI,4,A0,STI,0,B2,STI,4,A0,STI,0,B2
	.db STI,4,A0,STI,0,G2,STI,4,SL9,A0,STI,0,SL3,AS2,STI,4,SL9,A0,STI,0
	.db SL3,G2,STI,4,SL9,A0,STI,0,SL3,AS2,STI,4,SL9,A0
	.db RET


XCellBattery_triangle_11:
	.db STI,4,SL6,A0,STI,0,SL3,B2,STI,4,A0,STI,0,B2,STI,4,A0,STI,0,B2
	.db STI,4,SL9,A0,STI,0,SL3,B2,STI,4,A0,STI,0,B2,STI,4,A0,STI,0,B2
	.db STI,4,A0,STI,0,G2,STI,4,SL9,A0,STI,0,SL3,AS2,STI,4,SL9,A0,STI,0
	.db SL3,G2,STI,4,SL9,A0,STI,0,SL3,AS2,STI,4,SL9,A0
	.db RET


XCellBattery_square1_32:
	.db STI,0,SL3,GS2,STI,4,SL9,A0,STI,0,SL3,DS1,STI,4,SLL,21,A0,STI,0
	.db SLL,48,DS1,STI,4,SLC,A0
	.db RET


XCellBattery_triangle_12:
	.db STI,0,SL3,GS2,STI,4,SL9,A0,STI,0,SL3,DS1,STI,4,SLL,21,A0,STI,0
	.db SLL,48,DS1,STI,4,SLC,A0
	.db RET


XCellBattery_square1_33:
	.db STI,0,SL3,GS2,STI,4,SLL,21,A0,STI,0,SL3,DS1,STI,4,SL9,A0,STI,0
	.db SL3,B2,STI,4,SLL,21,A0,STI,0,SL3,AS2,STI,4,SL9,A0,STI,0,SL3,GS2
	.db STI,4,SL9,A0,STI,0,SLC,AS2
	.db RET


XCellBattery_triangle_13:
	.db STI,0,SL3,GS2,STI,4,SLL,21,A0,STI,0,SL3,DS1,STI,4,SL9,A0,STI,0
	.db SL3,B2,STI,4,SLL,21,A0,STI,0,SL3,AS2,STI,4,SL9,A0,STI,0,SL3,GS2
	.db STI,4,SL9,A0,STI,0,SLC,AS2
	.db RET


XCellBattery_square1_34:
	.db STI,4,SLC,A0,STI,2,SL6,AS2,STI,4,A0,STI,2,AS2,STI,4,A0,STI,2
	.db AS2,STI,4,A0,STI,2,AS2,STI,4,A0,STI,2,AS2,STI,4,A0,STI,2,AS2
	.db STI,4,A0,STI,2,AS2,STI,4,A0
	.db RET


XCellBattery_triangle_14:
	.db STI,1,SL6,AS2,STI,4,A0,STI,1,AS2,STI,4,A0,STI,1,AS2,STI,4,A0
	.db STI,1,AS2,STI,4,A0,STI,1,AS2,STI,4,A0,STI,1,AS2,STI,4,A0,STI,1
	.db AS2,STI,4,A0,STI,1,AS2,STI,4,A0
	.db RET


XCellBattery_square1_35:
	.db STI,4,SLC,A0,STI,2,SL6,A2,STI,4,A0,STI,2,A2,STI,4,A0,STI,2,A2
	.db STI,4,A0,STI,2,A2,STI,4,A0,STI,2,A2,STI,4,A0,STI,2,A2,STI,4,A0
	.db STI,2,A2,STI,4,A0
	.db RET


XCellBattery_triangle_15:
	.db STI,4,SLC,A0,STI,1,SL6,A2,STI,4,A0,STI,1,A2,STI,4,A0,STI,1,A2
	.db STI,4,A0,STI,1,A2,STI,4,A0,STI,1,A2,STI,4,A0,STI,1,A2,STI,4,A0
	.db STI,1,A2,STI,4,A0
	.db RET


XCellBattery_square1_36:
	.db STI,4,SLL,96,A0
	.db RET


XCellBattery_triangle_16:
	.db STI,0,SL6,GS2,STI,4,A0,STI,0,GS2,STI,4,SLC,A0,STI,0,SL6,GS2,STI,4
	.db SLC,A0,STI,0,SL6,GS2,STI,4,A0,STI,0,GS2,STI,4,SLC,A0,STI,0,SL6
	.db GS2,STI,4,SLC,A0
	.db RET


XCellBattery_triangle_17:
	.db STI,0,SL6,B2,STI,4,A0,STI,0,B2,STI,4,SLC,A0,STI,0,SL6,AS2,STI,4
	.db SLC,A0,STI,0,SL6,AS2,STI,4,A0,STI,0,A2,STI,4,SLC,A0,STI,0,SL6
	.db GS2,F2,STI,4,A0
	.db RET


XCellBattery_square1_37:
	.db STI,0,SL6,DS4,STI,4,SLL,42,A0,STI,0,SL6,DS4,STI,4,SLL,18,A0,STI,0
	.db SL6,DS4,STI,4,A0,STI,0,DS4,E4
	.db RET


XCellBattery_triangle_18:
	.db STI,0,SL6,GS2,STI,4,A0,STI,0,GS2,STI,4,SLC,A0,STI,0,SL6,GS2,STI,4
	.db SLC,A0,STI,0,SL6,GS2,STI,4,A0,STI,0,GS2,STI,4,SLC,A0,STI,0,SL6
	.db GS2,STI,4,SLC,A0
	.db RET


XCellBattery_noise_3:
	.db STI,0,SL3,#$3,STI,4,SLL,45,0,STI,0,SL3,#$3,STI,4,SLL,21,0,STI,0
	.db SL3,#$3,STI,4,SL9,0,STI,0,SL3,#$3,STI,4,0,STI,0,#$3,STI,4,0
	.db RET


XCellBattery_square1_38:
	.db STI,0,SL6,DS4,STI,4,A0,STI,0,DS4,STI,4,A0,STI,0,SL4,DS4,STI,4
	.db SL2,A0,STI,0,SL4,DS4,STI,4,SL2,A0,STI,0,SL5,DS4,STI,4,SL7,A0
	.db STI,0,SL6,DS4,E4,DS4,D4,DS4,CS4,B3,AS3
	.db RET


XCellBattery_triangle_19:
	.db STI,0,SL6,B2,STI,4,A0,STI,0,B2,STI,4,SLC,A0,STI,0,SL6,AS2,STI,4
	.db SLC,A0,STI,0,SL6,AS2,STI,4,A0,STI,0,A2,STI,4,SLC,A0,STI,0,SL6
	.db GS2,F2,STI,4,A0
	.db RET


XCellBattery_noise_4:
	.db STI,0,SL3,#$3,STI,4,SL9,0,STI,0,SL3,#$3,STI,4,SL9,0,STI,0,SL3
	.db #$3,STI,4,0,STI,0,#$3,STI,4,0,STI,0,#$3,STI,4,SL9,0,STI,0,SL3
	.db #$3,STI,4,0,STI,0,#$3,STI,4,0,STI,0,#$3,STI,4,0,STI,0,#$3,STI,4
	.db SL9,0,STI,0,SL3,#$3,STI,4,0,STI,0,#$3,STI,4,0,STI,0,#$3,STI,4
	.db 0
	.db RET


XCellBattery_square1_39:
	.db STI,0,SL6,GS4,GS2,GS4,B2,STI,4,A0,STI,0,GS2,D3,DS3,STI,4,A0,STI,0
	.db DS3,FS3,G3,GS3,GS2,STI,4,SLC,A0
	.db RET


XCellBattery_triangle_20:
	.db STI,4,SL6,A0,STI,0,SL3,GS2,STI,4,A0,STI,0,GS2,STI,4,A0,STI,0
	.db GS2,STI,4,SL9,A0,STI,0,SL3,GS2,STI,4,A0,STI,0,GS2,STI,4,A0,STI,0
	.db GS2,STI,4,SL9,A0,STI,0,SL3,GS2,STI,4,A0,STI,0,GS2,STI,4,A0,STI,0
	.db GS2,STI,4,SL9,A0,STI,0,SL3,GS2,STI,4,A0,STI,0,GS2,STI,4,A0,STI,0
	.db GS2,STI,4,A0
	.db RET


XCellBattery_square1_40:
	.db STI,0,SL5,CS3,STI,4,SL1,A0,STI,0,SL5,CS3,STI,4,SLD,A0,STI,0,SL5
	.db B2,STI,4,SL1,A0,STI,0,SL5,B2,STI,4,SLD,A0,STI,0,SL6,GS2,STI,4
	.db SLC,A0,STI,0,SL6,GS4,STI,4,SLL,18,A0,STI,0,SL6,GS2
	.db RET


XCellBattery_triangle_21:
	.db STI,4,SL6,A0,STI,0,SL3,B2,STI,4,A0,STI,0,B2,STI,4,A0,STI,0,B2
	.db STI,4,A0,STI,0,AS2,STI,4,A0,STI,0,AS2,STI,4,SL9,A0,STI,0,SL3
	.db A2,STI,4,SL9,A0,STI,0,SL3,GS2,STI,4,A0,STI,0,GS2,STI,4,A0,STI,0
	.db GS2,STI,4,SLL,21,A0,STI,0,SL3,DS2,STI,4,A0
	.db RET


XCellBattery_square1_41:
	.db STI,4,SL6,A0,STI,0,GS2,B2,D3,STI,4,A0,STI,0,B2,D3,F3,STI,4,A0
	.db STI,0,D3,F3,GS3,STI,4,A0,STI,0,D3,F3,GS3
	.db RET


XCellBattery_triangle_22:
	.db STI,4,SL6,A0,STI,0,SL3,DS2,STI,4,A0,STI,0,G2,STI,4,A0,STI,0,GS2
	.db STI,4,SL9,A0,STI,0,SL3,GS2,STI,4,A0,STI,0,B2,STI,4,A0,STI,0,D3
	.db STI,4,SL9,A0,STI,0,SL3,D3,STI,4,A0,STI,0,F3,STI,4,A0,STI,0,FS3
	.db STI,4,SL9,A0,STI,0,SL3,E3,STI,4,A0,STI,0,F3,STI,4,A0,STI,0,FS3
	.db STI,4,A0
	.db RET


XCellBattery_square1_42:
	.db STI,0,SL6,FS3,GS3,DS3,GS2,FS3,GS3,DS3,GS2,DS3,FS3,CS3,GS2,DS3
	.db FS3,CS3,GS2
	.db RET


XCellBattery_triangle_23:
	.db STI,0,SL3,G3,STI,4,A0,STI,0,GS3,STI,4,A0,STI,0,GS3,STI,4,A0,STI,0
	.db GS3,STI,4,SL9,A0,STI,0,SL3,GS3,STI,4,A0,STI,0,GS3,STI,4,A0,STI,0
	.db GS3,STI,4,A0,STI,0,GS3,STI,4,A0,STI,0,GS3,STI,4,A0,STI,0,GS3
	.db STI,4,A0,STI,0,GS3,STI,4,A0,STI,0,GS3,STI,4,A0,STI,0,DS3,STI,4
	.db A0,STI,0,DS3,STI,4,A0,STI,0,DS3,STI,4,A0
	.db RET


XCellBattery_square1_43:
	.db STI,0,SL6,CS3,DS3,STI,4,A0,STI,0,GS2,STI,4,A0,STI,0,GS3,STI,4
	.db A0,STI,0,GS3,STI,4,A0,STI,0,GS3,FS3,DS3,FS3,GS3,STI,4,SLC,A0

	.db RET


XCellBattery_triangle_24:
	.db STI,4,SL6,A0,STI,0,SL3,GS2,STI,4,A0,STI,0,GS2,STI,4,A0,STI,0
	.db GS2,STI,4,SL9,A0,STI,0,SL3,GS2,STI,4,A0,STI,0,GS2,STI,4,A0,STI,0
	.db GS2,STI,4,SL9,A0,STI,0,SL3,B2,STI,4,A0,STI,0,B2,STI,4,A0,STI,0
	.db B2,STI,4,SL9,A0,STI,0,SL3,D3,STI,4,A0,STI,0,F3,STI,4,A0,STI,0
	.db GS3,STI,4,A0
	.db RET


XCellBattery_square1_44:
	.db STI,0,SL6,CS3,DS3,B2,CS3,AS2,B2,AS2,GS2,STI,4,A0,STI,0,GS2,DS3
	.db STI,4,A0,STI,0,G2,AS2,G2,AS2
	.db RET


XCellBattery_triangle_25:
	.db STI,4,SL6,A0,STI,0,SL3,B2,STI,4,A0,STI,0,B2,STI,4,A0,STI,0,B2
	.db STI,4,SL9,A0,STI,0,SL3,B2,STI,4,A0,STI,0,B2,STI,4,A0,STI,0,B2
	.db STI,4,A0,STI,0,G2,STI,4,SL9,A0,STI,0,SL3,AS2,STI,4,SL9,A0,STI,0
	.db SL3,G2,STI,4,SL9,A0,STI,0,SL3,AS2,STI,4,SL9,A0
	.db RET


XCellBattery_square1_45:
	.db STI,0,SLL,36,GS2,SLL,54,DS2,STI,4,SL6,A0
	.db RET


XCellBattery_triangle_26:
	.db STI,0,SL3,GS2,STI,4,SL9,A0,STI,0,SL3,DS2,STI,4,SLL,21,A0,STI,0
	.db SLL,48,DS2,STI,4,SLC,A0
	.db RET


XCellBattery_square1_46:
	.db STI,0,SL6,GS2,STI,4,SLL,18,A0,STI,0,SL6,DS2,STI,4,A0,STI,0,B2
	.db STI,4,SLL,18,A0,STI,0,SL6,AS2,STI,4,A0,STI,0,GS2,STI,4,A0,STI,0
	.db AS2,STI,4,A0
	.db RET


XCellBattery_triangle_27:
	.db STI,0,SL3,GS2,STI,4,SL9,A0,STI,0,SL3,DS2,STI,4,SLL,21,A0,STI,0
	.db SL3,B2,STI,4,SLL,21,A0,STI,0,SL3,AS2,STI,4,SL9,A0,STI,0,SL3,GS2
	.db STI,4,SL9,A0,STI,0,SLC,AS2
	.db RET


XCellBattery_square1_47:
	.db STI,4,SLC,A0,STI,0,SL6,AS2,STI,4,A0,STI,0,AS2,STI,4,A0,STI,0
	.db AS2,STI,4,A0,STI,0,AS2,STI,4,A0,STI,0,AS2,STI,4,A0,STI,0,AS2
	.db STI,4,A0,STI,0,AS2,STI,4,A0
	.db RET


XCellBattery_triangle_28:
	.db STI,4,SLL,78,A0,SLL,18,A0
	.db RET


XCellBattery_square1_48:
	.db STI,4,SLC,A0,STI,0,SL6,A2,STI,4,A0,STI,0,A2,STI,4,A0,STI,0,A2
	.db STI,4,A0,STI,0,A2,STI,4,A0,STI,0,A2,STI,4,A0,STI,0,A2,STI,4,A0
	.db STI,0,A2,STI,4,A0
	.db RET


XCellBattery_square2_27:
	.db STI,4,SLL,96,A0
	.db RET


XCellBattery_triangle_29:
	.db STI,0,SLL,72,A2,STI,4,SLL,24,A0
	.db RET


XCellBattery_noise_5:
	.db STI,0,SL3,#$0,STI,4,SL9,0,STI,0,SL3,#$0,STI,4,0,STI,1,#$5,STI,4
	.db SLF,0,STI,1,SL3,#$5,STI,4,SLF,0,STI,1,SL3,#$5,STI,4,SL9,0,STI,0
	.db SL3,#$0,STI,4,0,STI,1,#$5,STI,4,SLL,21,0
	.db RET




_sfx_thump:
	.db 0, 1
	.db 0, 1
	.dw 0
	.dw 0
	.dw 0
	.dw sfx_thump_noise
	.dw 0




sfx_thump_noise:
	.db CAL,<(sfx_thump_noise_0),>(sfx_thump_noise_0)
	.db TRM


sfx_thump_noise_0:
	.db SLL,3,STI,0,#$3
	.db RET



.include SCR_EXTRA_SOUND_EFFECTS

