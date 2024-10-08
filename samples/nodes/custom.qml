/*
 Copyright (c) 2008-2024, Benoit AUTHEMAN All rights reserved.

 Redistribution and use in source and binary forms, with or without
 modification, are permitted provided that the following conditions are met:
    * Redistributions of source code must retain the above copyright
      notice, this list of conditions and the following disclaimer.
    * Redistributions in binary form must reproduce the above copyright
      notice, this list of conditions and the following disclaimer in the
      documentation and/or other materials provided with the distribution.
    * Neither the name of the author or Destrat.io nor the
      names of its contributors may be used to endorse or promote products
      derived from this software without specific prior written permission.

 THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
 ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
 WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
 DISCLAIMED. IN NO EVENT SHALL AUTHOR BE LIABLE FOR ANY
 DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
 (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
 LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
 ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/

import QtQuick                   2.12
import QtQuick.Controls          2.1
import QtQuick.Controls.Material 2.1
import QtQuick.Layouts           1.3

import QuickQanava as Qan

Qan.GraphView {
    anchors.fill: parent
    id: graphView
    navigable   : true
    PinchHandler {
        target: null
        onActiveScaleChanged: {
            console.error('centroid.position=' + centroid.position)
            console.error('activeScale=' + activeScale)
            var p = centroid.position
            var f = activeScale > 1.0 ? 1. : -1.
            navigable.zoomOn(p, navigable.zoom + (f * 0.03))
        }
    }
    graph: Qan.Graph {
        id: graph
        property var customNodeDelegate: Qt.createComponent("qrc:/CustomNode.qml")
        property var controlNodeDelegate: Qt.createComponent("qrc:/ControlNode.qml")
        property var diamondNodeDelegate: Qt.createComponent("qrc:/DiamondNode.qml")
        Component.onCompleted: {
            const rectNode = graph.insertNode()
            rectNode.label = "Rectangle"
            rectNode.item.x = 45; rectNode.item.y = 140

            const customNode = graph.insertNode(customNodeDelegate)
            customNode.item.x = 45; customNode.item.y = 280

            const diamondNode = graph.insertNode(diamondNodeDelegate)
            diamondNode.label = "Diamond"
            diamondNode.item.x = 280; diamondNode.item.y = 170

            const controlNode = graph.insertNode(controlNodeDelegate)
            controlNode.item.x = 540; controlNode.item.y = 140
        }
    }
}  // Qan.GraphView
