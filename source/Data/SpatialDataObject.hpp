#ifndef SPATIAL_DATA_OBJECT_HPP_
#define SPATIAL_DATA_OBJECT_HPP_

#include "DataObject.hpp"
#include "BoundingBox.hpp"
#include "SceneGraph.hpp"

namespace fast {

class SpatialDataObject : public DataObject {
    public:
        typedef SharedPointer<SpatialDataObject> pointer;
        SpatialDataObject();
        virtual BoundingBox getBoundingBox() const;
        virtual BoundingBox getTransformedBoundingBox() const;
        SceneGraphNode::pointer getSceneGraphNode() const;
    protected:
        BoundingBox mBoundingBox;
    private:
        SceneGraphNode::pointer mSceneGraphNode;

};

}

#endif