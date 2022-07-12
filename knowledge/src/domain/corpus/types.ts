import {Concept} from "../concept/types";
import {Relation} from "../relation/types";

interface Corpus {
    state: CorpusState;
    concepts: Concept[];
    relations: Relation[];
}
enum CorpusState {
    PENDING,
    INITIALIZING,
    READY
}
enum CorpusEvents {
    INITIALIZE,
    INITIALIZED
}
type CorpusReader = (corpus: Corpus, location: string) => Promise<Corpus>;

export {
    Corpus,
    CorpusState,
    CorpusReader
}
