import {Corpus, CorpusReader, CorpusState} from "./types";

const construct = (): Corpus => ({
    state: CorpusState.PENDING,
    concepts: [],
    relations: []
})

const initialize = async (corpus: Corpus, read: CorpusReader): Promise<Corpus> => {
    corpus.state = CorpusState.INITIALIZING;
    await read(corpus, '../../corpus/');
    corpus.state = CorpusState.READY;
}

export {
    construct,
    initialize
}