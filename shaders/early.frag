#version 330

in vec3 vNormal;

out vec3 colorOut;

void main()
{
    // normalize to [0,1]
    colorOut = 0.5 * (vNormal + vec3(1.0));
}
