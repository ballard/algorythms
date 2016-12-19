//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

class Node {
    // Name of the node visible to user
    var name = ""
    // If this field is true, children of the Node are shown to user
    var expanded = false
    // If this field is true, it means that node matches current search and it is emphasized
    var matched = false
    // Children of the node
    var children = NSMutableArray()
    /**
     * This function returns new subtree of the original tree which satisfies the following requirements:
     *   - Function doesn't modify original tree
     *   - The 'Node matches the search' term means that Node's name contains the 'search' as a substring (case insensitive)
     *   - Node is included in the resulting subtree if Node, one of its ancestors, or one of its descendants matches the search
     *   - If Node matches the search, its matched property must be set to true, otherwise false
     *   - If at least one descendant of the Node matches the search, Node's expanded property must be set to true, otherwise false
     */
    func search(_ s: String) -> Node? {
        if self.name.localizedCaseInsensitiveContains(s) {
            let node = Node()
            node.name = self.name
            for element in self.children {
                let nodeChild = element as! Node
                if let findedNode = nodeChild.search(s) {
                    node.children.add(findedNode)
                } else {
                    node.children.add(nodeChild)
                }
            }
            node.matched = true
            for element in node.children {
                let nodeChild = element as! Node
                if nodeChild.expanded || nodeChild.matched {
                    node.expanded = true
                    break
                }
            }
            return node
        } else {
            let node = Node()
            node.name = self.name
            for element in self.children {
                let nodeChild = element as! Node
                if let findedNode = nodeChild.search(s) {
                    node.children.add(findedNode)
                }
            }
            guard node.children.count != 0 else { return nil }
            node.expanded = true
            return node
        }
    }
}

extension Node: CustomStringConvertible {
    var description: String {
        var s = "\(name) (m: \(matched), e: \(expanded))"
        if children.count != 0 {
            for element in children {
                let node = element as! Node
                s += " {" + node.description + "}"
            }
        }
        return s
    }
}

let root = Node()
root.name = "root"

let alpha = Node()
alpha.name = "alpha"

let beta = Node()
beta.name = "beta"

let gamma = Node()
gamma.name = "gamma"

let delta = Node()
delta.name = "delta"

let epsilon = Node()
epsilon.name = "epsilon"

let dzeta = Node()
dzeta.name = "dzeta"

let etha = Node()
etha.name = "etha"

let tetha = Node()
tetha.name = "tetha"

let yota = Node()
yota.name = "yota"

let cappa = Node()
cappa.name = "cappa"

let lambda = Node()
lambda.name = "lambda"

let mu = Node()
mu.name = "mu"

let nu = Node()
nu.name = "nu"

root.children.add(alpha)
root.children.add(beta)

alpha.children.add(gamma)
alpha.children.add(delta)
alpha.children.add(epsilon)

gamma.children.add(etha)

delta.children.add(tetha)

epsilon.children.add(yota)
epsilon.children.add(cappa)

beta.children.add(dzeta)

dzeta.children.add(lambda)
dzeta.children.add(mu)
dzeta.children.add(nu)

print("Initial tree:\n \(root.description)\n\r")

if let searchedTree = root.search("l") {
    print("Created tree:\n \(searchedTree.description)\n\r")
}

print("Check initial tree:\n \(root.description)\n\r")


