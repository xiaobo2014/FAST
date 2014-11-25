#ifndef SURFACEEXTRACTION_HPP_
#define SURFACEEXTRACTION_HPP_

#include "Mesh.hpp"
#include "ProcessObject.hpp"
#include "Image.hpp"

namespace fast {

class SurfaceExtraction : public ProcessObject {
    FAST_OBJECT(SurfaceExtraction)
    public:
        void setThreshold(float threshold);
        void setInput(ImageData::pointer input);
        void setDevice(OpenCLDevice::pointer device);
        MeshData::pointer getOutput();
    private:
        SurfaceExtraction();
        void execute();

        ImageData::pointer mInput;
        MeshData::pointer mOutput;
        float mThreshold;
        OpenCLDevice::pointer mDevice;
        unsigned int mHPSize;
        cl::Program program;
        // HP
        std::vector<cl::Image3D> images;
        std::vector<cl::Buffer> buffers;

        cl::Buffer cubeIndexesBuffer;
        cl::Image3D cubeIndexesImage;
};

} // end namespace fast




#endif /* SURFACEEXTRACTION_HPP_ */
