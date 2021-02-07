#version 330

// In
in vec4 position;
in vec3 normal;

// Uni

uniform mat4 ModelViewMatrix;
uniform mat3 NormalMatrix;
uniform mat4 ProjectionMatrix;
uniform mat4 mPVM;

// Out
out vec3 VNormal;
out vec3 VPosition;


void main(){
    VNormal = normalize(NormalMatrix * normal);
    VPosition = vec3(ModelViewMatrix * position);
    gl_Position = mPVM * position;
}
