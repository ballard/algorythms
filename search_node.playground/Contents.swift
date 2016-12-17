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
    var children: [Node] = []
    
    /**
     * This function returns new subtree of the original tree which satisfies the following requirements:
     *   - Function doesn't modify original tree
     *   - The 'Node matches the search' term means that Node's name contains the 'search' as a substring (case insensitive)
     *   - Node is included in the resulting subtree if Node, one of its ancestors, or one of its descendants matches the search
     *   - If Node matches the search, its matched property must be set to true, otherwise false
     *   - If at least one descendant of the Node matches the search, Node's expanded property must be set to true, otherwise false
     */
    
    func search(_ s: String) -> Node? {
        let node = Node()
        node.name = self.name
        if self.name.localizedCaseInsensitiveContains(s) {
            let traversedChildren = self.children.map{ $0.search(s) ?? $0 }
            node.matched = true
            
            //let exp = traversedChildren.map{$0}.filter{ $0.expanded || $0.matched }.count != 0
            
            node.expanded = traversedChildren.map{$0}.filter{ $0.expanded || $0.matched }.count != 0
            
            /*for children in traversedChildren {
                if children.matched || children.expanded {
                    node.expanded = true
                    break
                }
            }*/
            
            node.children = traversedChildren
            return node
        } else {
            let traversedChildren = self.children.map{ $0.search(s) }.filter{ $0 != nil }
            if traversedChildren.count == 0 {
                return nil
            }
            node.expanded = true
            node.children = traversedChildren as! [Node]
            return node
        }
    }
}

extension Node: CustomStringConvertible {
    var description: String {
        var s = "\(name) (m: \(matched), e: \(expanded))"
        if !children.isEmpty {
            s += " {" + children.map { $0.description }.joined(separator: ", ") + "}"
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

root.children.append(alpha)
root.children.append(beta)

alpha.children.append(gamma)
alpha.children.append(delta)
alpha.children.append(epsilon)

beta.children.append(dzeta)

gamma.children.append(etha)

delta.children.append(tetha)

epsilon.children.append(yota)
epsilon.children.append(cappa)

dzeta.children.append(lambda)
dzeta.children.append(mu)
dzeta.children.append(nu)

print("Initial tree:\n \(root.description)\n\r")

if let searchedTree = root.search("l") {
    print("Created tree:\n \(searchedTree.description)\n\r")
}

print("Check initial tree:\n \(root.description)\n\r")


