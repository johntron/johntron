import {Concept} from "../concept/types";

enum Relations {
    helps,
    hurts,
}

interface Relation {
    from: Concept['title'];
    to: Concept['title'];
    type: Relations
}

export {
    Relation
}