#version 330

// in
in vec4 position;

// uniforms
uniform mat4 mPVM;

void main(){

    gl_Position = mPVM * position;
}
