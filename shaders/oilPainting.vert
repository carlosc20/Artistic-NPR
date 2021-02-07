#version 330

// In
in highp vec3 position;
in highp vec2 texCoord0;

// Uni
uniform highp mat4  mPVM;

// Out
smooth out highp vec2 texCoord;


void main(){
    texCoord = texCoord0;
    gl_Position = mPVM * vec4(position, 1.0f);
}
