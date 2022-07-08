abstract class DomainMapper<TEntity, TModel> {
  TEntity map(TModel model);
}
