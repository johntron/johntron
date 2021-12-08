// Snowpack Configuration File
// See all supported options: https://www.snowpack.dev/#configuration

/** @type {import("snowpack").SnowpackUserConfig } */
module.exports = {
  mount: {
    "src": "/"
  },
  plugins: [
    // [
    //   "snowpack-plugin-swc",
    //   {
    //     "input": ['.js', '.mjs', '.jsx', '.ts', '.tsx'], // (optional) specify files for swc to transform
    //     transformOptions: {
    //       // swc transform options
    //     }
    //   }
    // ]
  ],
  // installOptions: {},
  // devOptions: {},
  // buildOptions: {},
  packageOptions: {
    // source: "remote"
  }
};
