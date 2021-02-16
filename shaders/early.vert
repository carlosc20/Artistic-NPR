#version 330

in vec4 position;
in vec3 normal;

uniform mat4 mPVM;
uniform mat3 mNormal;

out vec3 vNormal;

void main()
{
    vNormal = mNormal * normal;
    gl_Position = mPVM * position;
}