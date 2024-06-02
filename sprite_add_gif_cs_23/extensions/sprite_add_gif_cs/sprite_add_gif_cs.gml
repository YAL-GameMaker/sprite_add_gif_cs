#define sprite_add_gif_cs
/// (path, xorigin, yorigin, ?delays_array)->sprite
var _path = argument[0], _xo = argument[1], _yo = argument[2];
var _delays_array = argument_count > 3 ? argument[3] : undefined;
var _buf = buffer_load(_path);
return sprite_add_gif_cs_buffer(_buf, _xo, _yo, _delays_array);

#define sprite_add_gif_cs_buffer
/// (buffer, xorigin, yorigin, ?delays_array)->sprite
var _buf = argument[0], _xo = argument[1], _yo = argument[2];
var _delays_array = argument_count > 3 ? argument[3] : undefined;
var _ab = sprite_add_gif_cs_prepare_buffer(12);
buffer_poke(_ab, 0, buffer_s32, -1);
var _error = sprite_add_gif_cs_start(
    buffer_get_address(_buf),
    buffer_get_size(_buf),
    buffer_get_address(_ab),
);
if (_error != "") {
    show_debug_message(_error);
    return -1;
}

var _count = buffer_peek(_ab, 0, buffer_s32);
if (_count == -1) {
    show_debug_message("DLL is not loaded.");
    return -1;
}

var _width = buffer_peek(_ab, 4, buffer_s32);
var _height = buffer_peek(_ab, 8, buffer_s32);
var _size = _width * _height * 4;
var _sprite = -1;

var _fb = sprite_add_gif_cs_prepare_buffer(_size);
var _surf = surface_create(_width, _height);

if (array_length(_delays_array) < _count) {
    array_resize(_delays_array, _count);
}

for (var i = 0; i < _count; i++) {
    _error = sprite_add_gif_cs_get_frame(
        i,
        buffer_get_address(_fb),
        _size,
        buffer_get_address(_ab),
    );
    if (_error != "") {
        show_debug_message(_error);
        break;
    }
    buffer_set_surface(_fb, _surf, 0);
    if (i == 0) {
        _sprite = sprite_create_from_surface(_surf, 0, 0, _width, _height, false, false, _xo, _yo);
    } else {
        sprite_add_from_surface(_sprite, _surf, 0, 0, _width, _height, false, false);
    }
    if (_delays_array != undefined) {
        _delays_array[@i] = buffer_peek(_ab, 0, buffer_s32);
    }
}
surface_free(_surf);

return _sprite;

#define sprite_add_gif_cs_prepare_buffer
/// (size:int)->buffer~
var _size = argument0;
gml_pragma("global", "global.__sprite_add_gif_cs_buffer = undefined");
var _buf = global.__sprite_add_gif_cs_buffer;
if (_buf == undefined) {
    _buf = buffer_create(_size, buffer_grow, 1);
    global.__sprite_add_gif_cs_buffer = _buf;
} else if (buffer_get_size(_buf) < _size) {
    buffer_resize(_buf, _size);
}
buffer_seek(_buf, buffer_seek_start, 0);
return _buf;

#define sprite_add_gif_cs_prepare_buffer_2
/// (size:int)->buffer~
var _size = argument0;
gml_pragma("global", "global.__sprite_add_gif_cs_buffer_2 = undefined");
var _buf = global.__sprite_add_gif_cs_buffer_2;
if (_buf == undefined) {
    _buf = buffer_create(_size, buffer_grow, 1);
    global.__sprite_add_gif_cs_buffer_2 = _buf;
} else if (buffer_get_size(_buf) < _size) {
    buffer_resize(_buf, _size);
}
buffer_seek(_buf, buffer_seek_start, 0);
return _buf;