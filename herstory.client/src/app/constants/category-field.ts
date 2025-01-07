export class TagColorMapping {
  private static readonly fieldColors = new Map<string, string>([
    ["Informatique et Technologie", "#9c8cfc"],
    ["Sciences exactes", "#74b7fc"],
    ["Sciences du vivant", "#9bc8fc"],
    ["Sciences humaines et sociales", "#b9a4fc"],
    ["Arts et Culture", "#b79cfc"],
    ["Sports", "#a4aefc"],
    ["Entrepreneuriat et Innovation", "#a494fc"],
    ["Politique et Géopolitique", "#84a4fc"],
    ["Ingénierie et Industrie", "#9c8cfc"],
    ["Santé et Bien-être", "#74b7fc"],
    ["Environnement et Développement durable", "#9bc8fc"],
    ["Éducation et Formation", "#b9a4fc"],
    ["Histoire et Géographie", "#b79cfc"],
    ["Langues et Littérature", "#a4aefc"]
  ]);

  private static readonly categoryColors = new Map<string, string>([
    ["Scientifique", "#a494fc"],
    ["Artiste", "#84a4fc"],
    ["Sportive", "#9c8cfc"],
    ["Ingénieure", "#74b7fc"],
    ["Entrepreneure", "#9bc8fc"],
    ["Éducatrice", "#b9a4fc"],
    ["Exploratrice", "#b79cfc"],
    ["Responsable de politiques", "#a4aefc"],
    ["Militante", "#a494fc"],
    ["Innovatrice", "#84a4fc"],
    ["Chercheuse", "#9c8cfc"],
    ["Botaniste", "#74b7fc"],
    ["Zoologiste", "#9bc8fc"]
  ]);

  /**
   * Retrieves the color associated with a given field.
   * @param field The name of the field.
   * @returns The color in hex format or a default color if not found.
   */
  static getFieldColor(field: string): string {
    return this.fieldColors.get(field) || "#cccccc"; // Default color if not found
  }

  /**
   * Retrieves the color associated with a given category.
   * @param category The name of the category.
   * @returns The color in hex format or a default color if not found.
   */
  static getCategoryColor(category: string): string {
    return this.categoryColors.get(category) || "#cccccc"; // Default color if not found
  }
}
