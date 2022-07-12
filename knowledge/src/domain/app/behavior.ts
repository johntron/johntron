import {construct, initialize as initializeCorpus} from "../corpus/behavior";
import {read} from '../../io/fs/read'

const initialize = async () => {
    const corpus = construct();
    await initializeCorpus(corpus, read);
}

export {
    initialize
}