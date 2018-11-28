```javascript
if (items[i].name != 'Aged Brie' && items[i].name != 'Backstage passes to a TAFKAL80ETC concert') {
  if (items[i].quality > 0) {
    if (items[i].name != 'Sulfuras, Hand of Ragnaros') {
      items[i].quality = items[i].quality - 1
    }
  }
} else {
  if (items[i].quality < 50) {
    items[i].quality = items[i].quality + 1
    if (items[i].name == 'Backstage passes to a TAFKAL80ETC concert') {
      if (items[i].sell_in < 11) {
        if (items[i].quality < 50) {
          items[i].quality = items[i].quality + 1
        }
      }
      if (items[i].sell_in < 6) {
        if (items[i].quality < 50) {
          items[i].quality = items[i].quality + 1
        }
      }
    }
  }
}
if (items[i].name != 'Sulfuras, Hand of Ragnaros') {
  items[i].sell_in = items[i].sell_in - 1;
}
if (items[i].sell_in < 0) {
  if (items[i].name != 'Aged Brie') {
    if (items[i].name != 'Backstage passes to a TAFKAL80ETC concert') {
      if (items[i].quality > 0) {
        if (items[i].name != 'Sulfuras, Hand of Ragnaros') {
          items[i].quality = items[i].quality - 1
        }
      }
    } else {
      items[i].quality = items[i].quality - items[i].quality
    }
  } else {
    if (items[i].quality < 50) {
      items[i].quality = items[i].quality + 1
    }
  }
}
```

---

class: middle, center

## Understand the domain better
## by simplifying conditionals 

---

class: middle, center

### Forget about what we're building
### Focus on the grammar

---
class: middle, left

## 1. Consolidate operands

---

### Original

```javascript
if (cat || has_tail) {
  if (has_tail) {
    wag()
  } else {
    meow()
  }
} else {
  bark()
}
```
---

### Forget domain

```javascript
if (A || B) {
  if (B) {
    a()
  } else {
    b()
  }
} else {
  c()
}
```

---

### Consolidated

```javascript
if (B) {
  a()
  return;
}

if (B) {
  b()
} else {
  c()
}
```

---

### Domain

```javascript
if (has_tail) {
  wag()
  return;
}

if (cat) {
  meow()
} else {
  bark()
}
```

---

class: middle, center

## What did we learn?

---

class: middle, left

## Wagging only requires a tail

```javascript
if (has_tail) {
  wag()
  return;
}
```

---


class: middle, center

## 2. Flip the condition, return ASAP

---

### Original

```javascript
if (should_show_warning) {
  // Branch 1
  lots()
  of()
  stuff()
} else {
  // Branch 2
  not_much();
}
```

---

### Obfuscated

```javascript
if (A) {
  // Branch 1
  a()
  b()
  c()
} else {
  // Branch 2
  d();
}
```

---

### Flip the conditional

```javascript
if (!A) {
  // Branch 2
  d();
} else {
  // Branch 1
  a()
  b()
  c()
}
```

---

### Return early

```javascript
if (!A) {
  d();
  return;
}

a()
b()
c()
```

---

### Domain

```javascript
if (!foo) {
  not_much();
  return;
}

lots()
of()
stuff()
```

---

class: middle, center

## What did we learn?

---

class: middle, left

## Absense of foo is an edge-case

```javascript
if (!foo) {
  not_much();
  return;
}

lots()
of()
stuff()
```

---

class: middle, left

## 3. Push specific stuff down

---

### Original

```javascript
if (homepage) {
  if (logged_in) {
    show_avatar() // specific
    show_homepage() // broad - lots of buried complexity
  } else {
    show_register_link()
    show_homepage()
  }
} else {
  if (logged_in) {
    show_avatar() // specific
    show_other_page() // broad
  } else {
    show_register_link()
    show_other_page()
  }
}
```

---

### Obfuscated

```javascript
if (A) {
  if (B) {
    specific_a() // specific
    broad_a() // broad
  } else {
    specific_b()
    broad_a()
  }
} else {
  if (B) {
    specific_a() // specific
    broad_b() // broad
  } else {
    specific_b()
    broad_b()
  }
}
```

---

### With specific stuff pushed down

```javascript
if (A) {
  broad_plus_specific_a(B) // lots of elements
} else {
  broad_plus_specific_b(B)
}

function broad_plus_specific_a(B) {
  if(B) {
    specific_a()
  } else {
    specific_b()
  }
  broad_a()
}

function broad_plus_specific_b(B) {
  if(B) {
    specific_a()
  } else {
    specific_b()
  }
  broad_b()
}
```
---

### After noticing duplication

```javascript
if (A) {
  broad_plus_specific_a(B) // lots of elements
} else {
  broad_plus_specific_b(B)
}

function broad_plus_specific_a(B) {
  specific(B)
  broad_a()
}

function broad_plus_specific_b(B) {
  specific(B)
  broad_b()
}

function specific(B) {
  if(B) {
    specific_a()
  } else {
    specific_b()
  }
}
```

---

### Domain

```javascript
if (homepage) {
  show_homepage_with_account(logged_in) // lots of elements
} else {
  show_other_page_with_account(logged_in)
}

function show_homepage_with_account(logged_in) {
  show_account(logged_in)
  show_homepage()
}

function show_other_page_with_account(logged_in) {
  show_account(logged_in)
  show_other_page()
}

function show_account(logged_in) {
  if(logged_in) {
    show_avatar()
  } else {
    show_register_link()
  }
}
```

---

class: middle, center 

## What did we learn?

---

class: middle, left
 
## Account stuff same across pages

```javascript
function show_homepage_with_account(logged_in) {
  show_account(logged_in)
  show_homepage()
}

function show_other_page_with_account(logged_in) {
  show_account(logged_in)
  show_other_page()
}
```

---

class: middle, center

### Forget about the domain
### Focus on the grammar
### Understand the domain better