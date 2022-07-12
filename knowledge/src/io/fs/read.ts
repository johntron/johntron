import {CorpusReader} from "../../domain/corpus/types";
import {readdir} from "fs/promises";

const read: CorpusReader = async (corpus, path) => {
    for (const item of await readdir(path)) {
        console.log(item);
    }

    return corpus;
}
export {read};