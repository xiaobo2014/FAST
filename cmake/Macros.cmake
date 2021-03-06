#### Macro for adding source files and directories
macro (fast_add_sources)
    file (RELATIVE_PATH _relPath "${PROJECT_SOURCE_DIR}" "${CMAKE_CURRENT_SOURCE_DIR}")
    foreach (_src ${ARGN})
        if (_relPath)
            list (APPEND FAST_SOURCE_FILES "${_relPath}/${_src}")
        else()
            list (APPEND FAST_SOURCE_FILES "${_src}")
        endif()
    endforeach()
    if (_relPath)
        # propagate FAST_SOURCE_FILES to parent directory
        set (FAST_SOURCE_FILES ${FAST_SOURCE_FILES} PARENT_SCOPE)
    endif()
endmacro()

macro (fast_add_test_sources)
    file (RELATIVE_PATH _relPath "${PROJECT_SOURCE_DIR}" "${CMAKE_CURRENT_SOURCE_DIR}")
    foreach (_src ${ARGN})
        if (_relPath)
            list (APPEND FAST_TEST_SOURCE_FILES "${_relPath}/${_src}")
        else()
            list (APPEND FAST_TEST_SOURCE_FILES "${_src}")
        endif()
    endforeach()
    if (_relPath)
        # propagate FAST_TEST_SOURCE_FILES to parent directory
        set (FAST_TEST_SOURCE_FILES ${FAST_TEST_SOURCE_FILES} PARENT_SCOPE)
    endif()
endmacro()

macro (fast_add_python_interfaces)
    file (RELATIVE_PATH _relPath "${PROJECT_SOURCE_DIR}" "${CMAKE_CURRENT_SOURCE_DIR}")
    foreach (_src ${ARGN})
        if (_relPath)
            list (APPEND FAST_PYTHON_INTERFACE_FILES "${_relPath}/${_src}")
        else()
            list (APPEND FAST_PYTHON_INTERFACE_FILES "${_src}")
        endif()
    endforeach()
    if (_relPath)
        # propagate FAST_PYTHON_INTERFACE_FILES to parent directory
        set (FAST_PYTHON_INTERFACE_FILES ${FAST_PYTHON_INTERFACE_FILES} PARENT_SCOPE)
    endif()
endmacro()

macro (fast_add_subdirectories)
    file (RELATIVE_PATH _relPath "${PROJECT_SOURCE_DIR}" "${CMAKE_CURRENT_SOURCE_DIR}")
    foreach (_src ${ARGN})
        add_subdirectory(${_src})
    endforeach()
    if (_relPath)
        # propagate to parent directory
        set (FAST_TEST_SOURCE_FILES ${FAST_TEST_SOURCE_FILES} PARENT_SCOPE)
        set (FAST_SOURCE_FILES ${FAST_SOURCE_FILES} PARENT_SCOPE)
        set (FAST_EXAMPLES ${FAST_EXAMPLES} PARENT_SCOPE)
        set (FAST_PROCESS_OBJECT_NAMES ${FAST_PROCESS_OBJECT_NAMES} PARENT_SCOPE)
        set (FAST_PROCESS_OBJECT_HEADER_FILES ${FAST_PROCESS_OBJECT_HEADER_FILES} PARENT_SCOPE)
        set (FAST_INFERENCE_ENGINE_NAMES ${FAST_INFERENCE_ENGINE_NAMES} PARENT_SCOPE)
        set (FAST_INFERENCE_ENGINE_HEADER_FILES ${FAST_INFERENCE_ENGINE_HEADER_FILES} PARENT_SCOPE)
        set (FAST_PYTHON_INTERFACE_FILES ${FAST_PYTHON_INTERFACE_FILES} PARENT_SCOPE)
    endif()
endmacro()

macro (fast_add_all_subdirectories)
    file(GLOB children RELATIVE ${CMAKE_CURRENT_SOURCE_DIR} ${CMAKE_CURRENT_SOURCE_DIR}/*)
    foreach(child ${children})
        if(IS_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}/${child})
            add_subdirectory(${CMAKE_CURRENT_SOURCE_DIR}/${child})
        endif()
    endforeach()
    if (_relPath)
        # propagate to parent directory
        set (FAST_TEST_SOURCE_FILES ${FAST_TEST_SOURCE_FILES} PARENT_SCOPE)
        set (FAST_SOURCE_FILES ${FAST_SOURCE_FILES} PARENT_SCOPE)
        set (FAST_EXAMPLES ${FAST_EXAMPLES} PARENT_SCOPE)
        set (FAST_PROCESS_OBJECT_NAMES ${FAST_PROCESS_OBJECT_NAMES} PARENT_SCOPE)
        set (FAST_PROCESS_OBJECT_HEADER_FILES ${FAST_PROCESS_OBJECT_HEADER_FILES} PARENT_SCOPE)
        set (FAST_INFERENCE_ENGINE_NAMES ${FAST_INFERENCE_ENGINE_NAMES} PARENT_SCOPE)
        set (FAST_INFERENCE_ENGINE_HEADER_FILES ${FAST_INFERENCE_ENGINE_HEADER_FILES} PARENT_SCOPE)
        set (FAST_PYTHON_INTERFACE_FILES ${FAST_PYTHON_INTERFACE_FILES} PARENT_SCOPE)
    endif()
endmacro()

### Macro for add examples
macro (fast_add_example NAME)
    if(FAST_BUILD_EXAMPLES)
        list(APPEND FAST_EXAMPLES ${NAME})
        add_executable(${NAME} ${ARGN})
        target_link_libraries(${NAME} FAST)
        install(TARGETS ${NAME}
                DESTINATION fast/bin
        )
        if(WIN32)
            file(APPEND ${PROJECT_BINARY_DIR}/runAllExamples.bat "bin\\${NAME}.exe\r\n")
        else()
            file(APPEND ${PROJECT_BINARY_DIR}/runAllExamples.sh "./bin/${NAME}\n")
        endif()
        file (RELATIVE_PATH _relPath "${PROJECT_SOURCE_DIR}" "${CMAKE_CURRENT_SOURCE_DIR}")
        if(_relPath)
            # propagate to parent directory
            set(FAST_EXAMPLES ${FAST_EXAMPLES} PARENT_SCOPE)
        endif()
    endif()
endmacro()

### Macro for add tool
macro (fast_add_tool NAME)
    if(FAST_BUILD_TOOLS)
        list(APPEND FAST_TOOLS ${NAME})
        add_executable(${NAME} ${ARGN})
        target_link_libraries(${NAME} FAST)
        install(TARGETS ${NAME}
                DESTINATION fast/bin
        )
        file (RELATIVE_PATH _relPath "${PROJECT_SOURCE_DIR}" "${CMAKE_CURRENT_SOURCE_DIR}")
        if(_relPath)
            # propagate to parent directory
            set(FAST_TOOLS ${FAST_TOOLS} PARENT_SCOPE)
        endif()
    endif()
endmacro()

### Macro for add process objects
macro(fast_add_process_object NAME HEADERFILE)
    file (RELATIVE_PATH _relPath "${PROJECT_SOURCE_DIR}/source/" "${CMAKE_CURRENT_SOURCE_DIR}")
    list(APPEND FAST_PROCESS_OBJECT_NAMES ${NAME})
    if(_relPath)
        list(APPEND FAST_PROCESS_OBJECT_HEADER_FILES ${_relPath}/${HEADERFILE})
    endif()
    if(_relPath)
        # propagate to parent directory
        set(FAST_PROCESS_OBJECT_NAMES ${FAST_PROCESS_OBJECT_NAMES} PARENT_SCOPE)
        set(FAST_PROCESS_OBJECT_HEADER_FILES ${FAST_PROCESS_OBJECT_HEADER_FILES} PARENT_SCOPE)
    endif()
endmacro()

### Macro for add inference engines
macro(fast_add_inference_engine NAME HEADERFILE)
    file (RELATIVE_PATH _relPath "${PROJECT_SOURCE_DIR}/source/" "${CMAKE_CURRENT_SOURCE_DIR}")
    list(APPEND FAST_INFERENCE_ENGINE_NAMES ${NAME})
    if(_relPath)
        list(APPEND FAST_INFERENCE_ENGINE_HEADER_FILES ${_relPath}/${HEADERFILE})
    endif()
    if(_relPath)
        # propagate to parent directory
        set(FAST_INFERENCE_ENGINE_NAMES ${FAST_INFERENCE_ENGINE_NAMES} PARENT_SCOPE)
        set(FAST_INFERENCE_ENGINE_HEADER_FILES ${FAST_INFERENCE_ENGINE_HEADER_FILES} PARENT_SCOPE)
    endif()
endmacro()