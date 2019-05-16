# heatmap
mask = np.zeros_like(data.corr())
mask[np.triu_indices_from(mask)] = True
with sns.axes_style("white"):
    ax = sns.heatmap(data.corr(), vmax=.3, center=1, square=True, linewidths=.5,annot=True, mask=mask)
plt.show()

# bar plot
data.groupby(['country'])["gdp_per_capita ($)"].mean().nlargest(10).plot(kind='barh', color="r", alpha=0.6)
plt.title("Top 10 Countries With the Largest Average GDP Per Capita ($)")
plt.xlabel("GDP Per Capita ($)")

data.groupby(['country','age', "sex"])["suicides/100k pop"].mean().nlargest(10).plot(kind='barh', 
                                                                                     color='blue', alpha=0.5)

data.groupby(['country','age']).suicides_no.sum().nlargest(10).plot(kind='barh', color='orange', alpha=0.5)
plt.title("Top 10 Country,Age Groups With the Highest Suicides Number 1985-2015")
plt.xlabel("Suicides Number")

# bubble plot
sns.relplot(y="suicides/100k pop", x="gdp_per_capita ($)", hue="generation", size="suicides/100k pop",
            sizes=(20, 500), alpha=.5, palette="muted", aspect=2,
            height=6, data=data_2)
plt.title(f"Suicides Per 100K Population vs GDP Per Capita ($) By Generation\n")
plt.ylabel("Number of Suicides Per 100K Population\n")
plt.xlabel("\nGDP Per Capita ($)")
plt.show()