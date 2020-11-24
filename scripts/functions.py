#Load the data in the crime.db
def replace(series):
    import re
    import pandas as pd
    series = series.str.normalize('NFKD').\
        str.encode('ascii', errors='ignore').str.decode('utf-8')
    names = [c for c in series]
    names = [re.sub('^St',' Saint ',name) for name in names]
    names = [re.sub('\&',' and ',name) for name in names]
    names = [re.sub('\s+e\s+',' and ',name) for name in names]
    names = [re.sub('[.,()-]',' ',name) for name in names]
    names = [re.sub('[.,()-]',' ',name) for name in names]
    names = [re.sub('\s+',' ',name) for name in names]
    names = [name.lower() for name in names]
    names = [name.strip() for name in names]
    return names

def country_codes(df,name_column):
    import jellyfish
    import pandas as pd
    #take the countries df
    file = '../SQL/Data/country_names.csv'
    country = pd.read_csv(file,keep_default_na=False)
    names = replace(country['country'])
    #take the df and look for the country column
    df['country_code'] = ''
    col_name = name_column.lower()
    countries = replace(df[col_name])
    # find the countries
    for i,c in enumerate(countries):
        cc = c.split()
        try:
            if c in names:
                index = [names.index(i) for i in names if (
                    c in i) & (c.split()[0] == i.split()[0])]
                df.country_code[i] = country['code'][index[0]]
            elif c in ['channel islands','united kingdom']:
                df.country_code[i] = 'GB'
            elif c in ['united kingdom']:
                df.country_code[i] = 'GB'
            elif c in ['virgin islands united kingdom']:
                df.country_code[i] = 'VG'
            elif c in ['virgin islands usa']:
                df.country_code[i] = 'VI'
            elif (cc[0] in names) & (cc[0] != 'saint'):
                index = [names.index(i) for i in names if cc[0] in i]
                df.country_code[i] = country['code'][index[0]]
            elif (cc[0]+' '+cc[1]) in names:
                index = [names.index(i) for i in names if (cc[0]+' '+cc[1]) in i]
                df.country_code[i] = country['code'][index[0]]
            elif (cc[1] in names) & (cc[0] not in ['of','and','drc','republic']):
                index = [names.index(i) for i in names if cc[1] in i]
                df.country_code[i] = country['code'][index[0]]
            elif (cc[0]+' '+cc[1]+ ' '+ cc[2]) in names:
                index = [names.index(i) for i in names if (cc[0]+' '+cc[1]+ ' '+ cc[2]) in i]
                df.country_code[i] = country['code'][index[0]]
            elif (cc[1] in names):
                index = [names.index(i) for i in names if (cc[1]) in i]
                df.country_code[i] = country['code'][index[0]]
        except:
            print(c , 'not found')
    return df
