#version 330

// In
in vec3 GPosition; // Position in camera coords
in vec3 GNormal; // Normal in camera coords.
flat in int GIsEdge; // Whether or not we're drawing an edge

uniform vec4 LineColor;

// Out
out vec4 colorOut;

void main(){
    if(GIsEdge == 1){
        colorOut = LineColor;
    }
    else{
        colorOut = vec4(1.0, 0.0, 0.0, 1.0);
    }
}