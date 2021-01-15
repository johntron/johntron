const nodeFetch = require('node-fetch')
export { fetch, fetchAsJson }

const cookie = `
JSESSIONID=D1562A6BF6E1760E433F94F4DB09CD3A; BIGipServerSTIS=729288876.29737.0000; _ga=GA1.2.1844694991.1587906817; check=true; _gcl_au=1.1.11103778.1588047778; rxVisitor=15880477775488N68U8AHBTLS33ARARG51DA4HMV10KUI; AMCVS_94001C8B532957140A490D4D%40AdobeOrg=1; AMCV_94001C8B532957140A490D4D%40AdobeOrg=-1712354808%7CMCIDTS%7C18381%7CMCMID%7C19502058093632177531815867721605862245%7CMCAAMLH-1588652578%7C9%7CMCAAMB-1588652578%7CRKhpRz8krg2tLO6pguXWp5olkAcUniQYPHaMWWgdJ3xzPWQmdj0y%7CMCOPTOUT-1588054978s%7CNONE%7CMCAID%7C2F3553370515D790-4000062524B57759%7CvVersion%7C4.3.0; soa-visitor=04272020BdaORM5e00fgUaMhuWzV1Orj; s_getval=04272020BdaORM5e00fgUaMhuWzV1Orj; s_cc=true; _fbp=fb.1.1588047778580.730178154; LPVID=EyNTgyODYwNzA0YjBkNWNh; LPSID-22435102=RwROXcSMSLil0IGIS1MOuA; s_sq=%5B%5BB%5D%5D; s_ppvl=https%253A%2F%2Fwww.subaru.com%2Fowners%2Fvehicle-resources%2Fmanuals.html%253FmodelCode%253D2017-FOR-HFA%2C35%2C35%2C986%2C1792%2C986%2C1792%2C1120%2C2%2CP; s_ppv=https%253A%2F%2Fwww.subaru.com%2Fowners%2Fvehicle-resources%2Fmanuals.html%253FmodelCode%253D2017-FOR-HFA%2C68%2C29%2C2269%2C1792%2C986%2C1792%2C1120%2C2%2CP; dtLatC=2; mbox=session#4dc6de508721448f816601954480049a#1588049638|PC#4dc6de508721448f816601954480049a.17_0#1651292625; dtPC=8$447824586_2h-vPJRROKMDUWWJRFFHDOMVAHEGEIAUTLHJ-0; dtSa=true%7CKD%7C-1%7CPage%3A%20vehicle-resources.html%7C-%7C1588047835027%7C447824586_2%7Chttps%3A%2F%2Fwww.subaru.com%2Fowners%2Fvehicle-resources.html%7CVehicle%20Resources%20%5Ep%20Subaru%7C1588047829784%7C%7C; dtCookie=8$VIRUGK9PV1M107K69VBN1H4KJ21MAI8R|03b0f856cc7e7c0c|1; _4c_=jVJNT9tAFPwraA%2BcYnu%2FPyKhKgFaUQkQpT30FDm7a2zhxO7aiQuI%2F963iRNQkarmYO3Ozpu8Gc0LGkq%2FRlMitMZcaSYwkxP06J86NH1Bto3fbfxsQo2mqOz7tptm2TAMabdZ5mGT2maVNcPahy7b%2BrKytU%2BC75pNsL5Ly35VowmyjfMwTUxKSEoA6J%2FhmjCM4dyGxm1sv%2Bif2kga%2FPKkc4%2Fw4Py2sn4xVK4v47Qy9A0tffVQ9hEmNKq4NsAlEoZq7Zrh77ERPY4ZLQG933lY%2FLi6AAju85%2B3i6t11Vd5H3e5AWgZmqHzUfy8DM3Kn%2BhooIF80HVu4Rh84UPYMd7H89A0D7XfxQOkrtoJvmU2YpD0EQbo9vr7t8X8cnZ%2Be%2FNObv%2FcFPnKh8rmaWfTZtUHZ9O177Nl1nUjJf4ZwdnX%2B4SmhKc4uVB3N1lHmKJUc2qIwFp%2Fmt3Nz8jpqnJnxAhMsdDYMMkoUUowoqELUilKJDxISrk4zYFKPzMhGFNYEHGhDE44hp%2BkgvK5gEFzOru7PIvRtNAXxOBQNzavo2to2AR9mY0xE825NNwYqILQICU1UQfv1%2Bd7zn8thl4n6Pe%2BvIRxSoXEUN6%2Bh6ZqudsPAyNUbmwxEtRrwXOecEpYwhXFiTbCJUzqojCK65waNGoaoSlTSktCQWRbHTSoc57ZZZFYvHQJd4VPcqZAw7KCecyp1QU67oW5kXEvPO5F9GGtth4VyRtZglWwxg9kfjTRbkc2%2B2BZfLT8a5PXyb64iV%2F%2FY%2FZDXK%2BvfwA%3D; rxvt=1588049635058|1588047777550; _gid=GA1.2.57515121.1588210783
`.trim()
const fetch = async (url, opts) => {
  const finalOpts = {
    "method": "GET",
    "referrer": "https://techinfo.subaru.com/stis/",
    "referrerPolicy": "no-referrer-when-downgrade",
    "mode": "cors",
    ...opts,
    headers: {
      "accept": "application/json, text/plain, */*",
      "accept-language": "en-US,en;q=0.9,vi-VN;q=0.8,vi;q=0.7",
      "cache-control": "no-cache",
      "content-type": "application/json;charset=UTF-8",
      "pragma": "no-cache",
      "sec-fetch-dest": "empty",
      "sec-fetch-mode": "cors",
      "sec-fetch-site": "same-origin",
      "cookie": cookie,
      ...opts.headers,
    }
  }
  return nodeFetch(url, finalOpts)
}

const responseText = async response => response.text()
const responseJson = async response => response.json()
const fetchAs = converter => async (url, opts) => converter(await fetch(url, opts))
const fetchAsText = fetchAs(responseText)
const fetchAsJson = fetchAs(responseJson)