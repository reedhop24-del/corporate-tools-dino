# Dino Refactor

- Put the Dino logic from a single function call into a reusable OOP with a class for the Dino Management that creates a Dino class. 
- A logical change that I refactored is that calculating age_metrics was dependent on the comment field, which comment in turn was dependent on health. That is a layer of dependency we do not need, it decreased the readability of the code and made it more brittle. If the logic in comment changes it would inadvertanly break the age_metric field.
- I introduced a private method `preferred_diet` which will check to make sure the category matches what the dino should be eating rather than the below nasty if block:
```
      if d['category'] == 'herbivore'
        d['health'] = d['diet'] == 'plants' ? (100 - d['age']) : (100 - d['age']) / 2
      else
        if d['category'] == 'carnivore'
          d['health'] = d['diet'] == 'meat' ? (100 - d['age']) : (100 - d['age']) / 2
        end
      end
```