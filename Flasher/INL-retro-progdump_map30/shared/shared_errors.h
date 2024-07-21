#ifndef _shared_errors_h
#define _shared_errors_h

#define SUCCESS 			0
#define GEN_FAIL 			0xFF


//greater than 128 are possible avr return codes
#define ERR_UNKN_DICTIONARY 		128

#define ERR_UNKN_SWIM_OPCODE		130
#define ERR_UNKN_MISC_OPCODE		131

#define ERR_UNKN_JTAG_OPCODE		135
#define ERR_UNKN_CICCOM_OPCODE		136
#define ERR_UNKN_BOOTLOAD_OPCODE	138
#define ERR_UNKN_FWUPDATE_OPCODE	139

#define ERR_UNKN_PP_OPCODE		140
#define ERR_CTL_PIN_NOT_PRESENT		141

#define ERR_FWUPDATE_BAD_ADDR		142
#define ERR_FWUPDATE_HIJACK_FAIL	143

#define ERR_UNKN_IO_OPCODE		150
#define ERR_UNKN_SWIM_LANE		151
#define ERR_UNKN_JTAG_LANE		152

#define ERR_UNKN_NES_OPCODE		160
//
////reserved libusb erro			165
//
#define ERR_UNKN_SNES_OPCODE		170

#define ERR_UNKN_GAMEBOY_OPCODE		175
#define ERR_UNKN_GBA_OPCODE		176
#define ERR_UNKN_SEGA_OPCODE		177
#define ERR_UNKN_N64_OPCODE		178

#define ERR_UNKN_BUFF_OPCODE		180
#define ERR_BUFN_DOES_NOT_EXIST		181

#define ERR_BUFF_ALLOC_RANGE		190
#define ERR_BUFF_STATUS_ALREADY_ALLOC	191
#define ERR_BUFF_ID_ALREADY_ALLOC	192
#define ERR_BUFF_RAW_ALREADY_ALLOC	193
#define ERR_BUFF_ALLOC_SIZE_ZERO	194
#define ERR_BUFF_UNSUP_MEM_TYPE		195
#define ERR_BUFF_PART_NUM_RANGE		196

//#define ERR_OUT_CURLDBUF_STATUS		200
//#define ERR_OUT_CURLDBUF_TO_SMALL	201

#define ERR_UNKN_OPER_OPCODE		210

////max error number			255


#endif